class Api::StripeController < ApiController
  include Rails.application.routes.url_helpers

  before_action :set_api_key

  def checkout
    session = Stripe::Checkout::Session.create(
      customer_email: current_user.email,
      success_url: "#{ENV['APP_HOST']}/dashboard/subscription/edit?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: edit_dashboard_subscription_url(cancel: 'true'),
      payment_method_types: ['card'],
      mode: 'subscription',
      line_items: [{
        quantity: 1,
        price: ENV['STRIPE_PRICE_ID'],
      }],
    )

    render json: { sessionId: session.id }
  end

  def portal
    portal = Stripe::BillingPortal::Session.create({
      customer: current_user.stripe_customer_id,
      return_url: edit_dashboard_subscription_url
    })

    render json: { portalUrl: portal.url }
  end

  private

  def set_api_key
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
  end
end
