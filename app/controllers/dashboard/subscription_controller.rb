class Dashboard::SubscriptionController < DashboardController
  def edit
  end

  def success
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    stripe_session = Stripe::Checkout::Session.retrieve(params[:session_id])

    if stripe_session.customer_email != current_user.email
      return render text: 'Emails do not match.'
    end

    if stripe_session.payment_status != 'paid'
      return render text: 'Not paid.'
    end

    current_user.update_to_premium!(stripe_session.customer)

    redirect_to edit_dashboard_subscription_path
  end
end
