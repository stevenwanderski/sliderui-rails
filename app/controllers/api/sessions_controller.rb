class Api::SessionsController < ApiController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    user = User.find_by(email: params[:email])
    if user && user.password == params[:password]
      render json: user
    else
      render json: { errors: 'Incorrect login.' }, status: 401
    end
  end

  def update
    if @current_user.update(session_params.merge(confirmed: true))
      render json: @current_user
    else
      render json: { errors: @current_user.errors.full_messages.first }, status: 422
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
