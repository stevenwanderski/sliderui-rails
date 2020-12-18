class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    webhook_secret = ENV['STRIPE_WEBHOOK_SECRET']
    signature = request.env['HTTP_STRIPE_SIGNATURE']
    payload = request.body.read

    event = Stripe::Webhook.construct_event(
      payload,
      signature,
      webhook_secret
    )

    process_event!(event)

    render text: 'OK'
  end

  private

  def process_event!(event)
    return if !event

    case event.type
    when 'checkout.session.completed'
      # Payment is successful and the subscription is created.
      # You should provision the subscription.
      email = event.data.object.customer_email
      customer_id = event.data.object.customer

      return if !email || !customer_id

      user = User.find_by(email: email)
      return if !user

      user.update!(
        subscription_type: 'premium',
        subscription_status: 'active',
        stripe_customer_id: customer_id
      )

    when 'invoice.paid'
      # Continue to provision the subscription as payments continue to be made.
      # Store the status in your database and check when a user accesses your service.
      # This approach helps you avoid hitting rate limits.
      customer_id = event.data.object.customer
      user = User.find_by(stripe_customer_id: customer_id)

      return if !user

      user.update!(
        subscription_type: 'premium',
        subscription_status: 'active'
      )

    when 'invoice.payment_failed'
      # The payment failed or the customer does not have a valid payment method.
      # The subscription becomes past_due. Notify your customer and send them to the
      # customer portal to update their payment information.
      customer_id = event.data.object.customer
      user = User.find_by(stripe_customer_id: customer_id)

      return if !user

      user.update!(subscription_status: 'past_due')
    end
  end
end
