class Api::RegistrationsController < ApiController
  skip_before_action :authenticate_user!

  def create
    if User.exists?(email: registration_params[:email])
      return render json: { errors: 'Email already exists.' }, status: 422
    end

    user = User.new(registration_params)
    if user.save
      render json: { id: user.id, token: user.token }
    else
      render json: { errors: user.errors }
    end
  end

  def create_temp
    user = User.new
    if user.save
      render json: { id: user.id, token: user.token }
    else
      render json: { errors: user.errors }
    end
  end

  private

  def registration_params
    params.require(:registration).permit(:email, :password)
  end
end
