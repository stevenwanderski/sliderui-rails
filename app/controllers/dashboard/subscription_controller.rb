class Dashboard::SubscriptionController < DashboardController
  def edit
  end

  def success
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']

    session_id = params[:session_id]
    stripe_session = Stripe::Checkout::Session.retrieve(session_id)

    customer_email = stripe_session.customer_email
    customer_id = stripe_session.customer
    payment_status = stripe_session.payment_status

    if customer_email != current_user.email
      return render text: 'Emails do not match.'
    end

    if payment_status != 'paid'
      return render text: 'Not paid.'
    end

    current_user.update!(
      subscription_type: 'premium',
      subscription_status: 'active',
      stripe_customer_id: customer_id
    )

    redirect_to edit_dashboard_subscription_path
  end
end
