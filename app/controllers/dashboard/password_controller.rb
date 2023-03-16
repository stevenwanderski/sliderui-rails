class Dashboard::PasswordController < DashboardController
  def edit
  end

  def update
    @user = current_user

    if @user.update(user_params)
      bypass_sign_in(@user)
      redirect_to edit_dashboard_password_path, notice: 'Successfully saved.'
    else
      redirect_to edit_dashboard_password_path, alert: 'Could not save.'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
