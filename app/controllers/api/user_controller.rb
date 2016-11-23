class Api::UserController < ApiController
  def show
    render json: @current_user
  end

  def update
    if @current_user.update(user_params)
      render json: @current_user
    else
      render json: { errors: @current_user.errors.full_messages.first }, status: 422
    end
  end

  # An authenticated user is adding an email and
  # optionally a password to confirm the account.
  # After doing so, the user is a fully confirmed user.
  def confirm
    if user_params[:email].blank?
      return render json: { errors: 'Email cannot be blank.' }, status: 422
    end

    if @current_user.update(user_params.merge(confirmed: true))
      render json: @current_user
    else
      render json: { errors: @current_user.errors.full_messages.first }, status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
