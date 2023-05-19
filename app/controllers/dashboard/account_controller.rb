class Dashboard::AccountController < DashboardController
  def show
    if !current_user.paid?
      portal = Stripe::Checkout::Session.create({
        cancel_url: request.url,
        success_url: ENV['APP_HOST'] + '/dashboard/subscription/success?session_id={CHECKOUT_SESSION_ID}',
        line_items: [
          { price: ENV['STRIPE_PRICE_ID'], quantity: 1 },
        ],
        mode: 'payment',
        customer_email: current_user.email
      })

      @portal_url = portal[:url]
    end
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
