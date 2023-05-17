class Dashboard::SubscriptionController < DashboardController
  def checkout
    stripe_portal = Stripe::Checkout::Session.create({
      cancel_url: dashboard_account_url,
      success_url: ENV['APP_HOST'] + '/dashboard/subscription/success?session_id={CHECKOUT_SESSION_ID}',
      line_items: [
        { price: ENV['STRIPE_PRICE_ID'], quantity: 1 },
      ],
      mode: 'subscription',
      customer_email: current_user.email
    })

    redirect_to stripe_portal[:url]
  end

  def success
    stripe_session = Stripe::Checkout::Session.retrieve(params[:session_id])

    current_user.update!(
      stripe_customer_id: stripe_session[:customer],
      stripe_subscription_id: stripe_session[:subscription],
      subscription_status: 'subscribed'
    )

    redirect_to dashboard_sliders_path, notice: 'Thank you for upgrading your account!'
  end
end
