class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_subscription

  layout 'dashboard'

  private

  def ensure_subscription
    return if current_user.active?

    stripe_portal = Stripe::Checkout::Session.create({
      cancel_url: request.url,
      success_url: ENV['APP_HOST'] + '/dashboard/subscription/success?session_id={CHECKOUT_SESSION_ID}',
      line_items: [
        { price: ENV['STRIPE_PRICE_ID'], quantity: 1 },
      ],
      mode: 'payment',
      customer_email: current_user.email
    })

    @checkout_url = stripe_portal[:url]
  end
end
