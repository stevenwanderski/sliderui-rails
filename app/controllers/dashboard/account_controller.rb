class Dashboard::AccountController < DashboardController
  def show
    if current_user.subscribed?
      portal = Stripe::BillingPortal::Session.create({
        customer: current_user.stripe_customer_id,
        return_url: dashboard_account_url
      })
    else
      portal = Stripe::Checkout::Session.create({
        cancel_url: request.url,
        success_url: ENV['APP_HOST'] + '/dashboard/subscription/success?session_id={CHECKOUT_SESSION_ID}',
        line_items: [
          { price: ENV['STRIPE_PRICE_ID'], quantity: 1 },
        ],
        mode: 'subscription',
        customer_email: current_user.email
      })
    end

    @portal_url = portal[:url]
  end

  def update
    @user = current_user

    if @user.update(user_params)
      bypass_sign_in(@user)
      redirect_to dashboard_account_path, notice: 'Successfully saved.'
    else
      redirect_to dashboard_account_path, alert: 'Could not save.'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
