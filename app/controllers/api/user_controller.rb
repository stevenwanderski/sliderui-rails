class Api::UserController < ApiController
  def show
    render json: @current_user
  end

  def update
    if User.exists?(email: user_params[:email])
      return render json: { errors: 'Email already exists.' }, status: 422
    end

    if @current_user.update(user_params)
      render json: @current_user
    else
      render json: { errors: @current_user.errors }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
