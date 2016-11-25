class Api::SessionsController < ApiController
  skip_before_action :authenticate_user!, only: [:create]

  # Unauthenticated user attempting to authenticate
  # via the standard login form.
  def create
    user = User.find_by(email: params[:email])
    password = Digest::SHA2.new(512).hexdigest(params[:password])
    if user && user.password == password
      render json: user
    else
      render json: { errors: 'Incorrect login.' }, status: 401
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
