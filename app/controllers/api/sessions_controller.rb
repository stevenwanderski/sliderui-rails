class Api::SessionsController < ApiController
  skip_before_action :authenticate_user!

  def create
    user = User.find_by(email: params[:email])
    if user && user.password == params[:password]
      render json: { id: user.id, token: user.token }
    else
      render json: { errors: 'Incorrect login.' }, status: 401
    end
  end
end
