class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    event = get_stripe_webhook_event
    process_event!(event)

    render text: 'OK'
  end

  private

  def get_stripe_webhook_event
    webhook_secret = ENV['STRIPE_WEBHOOK_SECRET']
    signature = request.env['HTTP_STRIPE_SIGNATURE']
    payload = request.body.read

    Stripe::Webhook.construct_event(
      payload,
      signature,
      webhook_secret
    )
  end

  def process_event!(event)
    return if !event

    case event.type
    when 'customer.subscription.deleted'
      customer_id = event.data.object.customer
      user = User.find_by(stripe_customer_id: customer_id)
      user.update_to_free!

    when 'invoice.paid'
      customer_id = event.data.object.customer
      user = User.find_by(stripe_customer_id: customer_id)
      user.update_to_premium!(customer_id)

    when 'invoice.payment_failed'
      customer_id = event.data.object.customer
      user = User.find_by(stripe_customer_id: customer_id)
      user.update_to_free!
    end
  end
end
