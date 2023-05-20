class WebhooksController < ApplicationController
  # skip_before_action :verify_authenticity_token

  # def stripe
  #   webhook_secret = ENV['STRIPE_WEBHOOK_SECRET']
  #   signature = request.env['HTTP_STRIPE_SIGNATURE']
  #   payload = request.body.read

  #   begin
  #     event = Stripe::Webhook.construct_event(
  #       payload,
  #       signature,
  #       webhook_secret
  #     )
  #   rescue JSON::ParserError => e
  #       # Invalid payload
  #       status 400
  #       return
  #   rescue Stripe::SignatureVerificationError => e
  #       # Invalid signature
  #       status 400
  #       return
  #   end

  #   # Handle the event
  #   case event.type
  #   when 'customer.subscription.deleted'
  #     customer_id = event.data.object.customer
  #     user = User.find_by(stripe_customer_id: customer_id)
  #     user.update!(
  #       subscription_status: 'cancelled'
  #     )
  #   end

  #   render plain: 'OK'
  # end
end
