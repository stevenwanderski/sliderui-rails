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

  def confirm
    if user_params[:email].blank?
      return render json: { errors: 'Email cannot be blank.' }, status: 422
    end

    if @current_user.update(email: user_params[:email], confirmed: true)
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
