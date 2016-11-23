class Api::RegistrationsController < ApiController
  skip_before_action :authenticate_user!

  def create
    user = User.new(registration_params)
    if user.save
      render json: user
    else
      render json: { errors: user.errors.full_messages.first }
    end
  end

  def create_temp
    user = User.new
    if user.save
      render json: user
    else
      render json: { errors: user.errors.full_messages.first }
    end
  end

  private

  def registration_params
    params.require(:registration).permit(:email, :password)
  end
end
