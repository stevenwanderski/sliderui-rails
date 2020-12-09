class Api::CheckoutController < ApiController
  def create
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']

    # See https://stripe.com/docs/api/checkout/sessions/create
    # for additional parameters to pass.
    # {CHECKOUT_SESSION_ID} is a string literal; do not change it!
    # the actual Session ID is returned in the query parameter when your customer
    # is redirected to the success page.
    session = Stripe::Checkout::Session.create(
      success_url: "#{ENV['APP_HOST']}/dashboard/subscription/edit?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: "#{ENV['APP_HOST']}/dashboard/subscription/edit?cancel=true",
      payment_method_types: ['card'],
      mode: 'subscription',
      line_items: [{
        quantity: 1,
        price: params[:priceId],
      }],
    )

    render json: { sessionId: session.id }
  end
end
