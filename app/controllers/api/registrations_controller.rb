class Api::RegistrationsController < ApiController
  skip_before_action :authenticate_user!

  # User is not authenticated and signs up from
  # registration form. Creates a user with an
  # email and password, and sets `confirmed` to `true`.
  # An access token is generated for the user.
  def create
    if params[:email].blank?
      return render json: { errors: 'Email is required' }, status: 422
    end

    user = User.new(registration_params.merge(confirmed: true))
    if user.save
      render json: user
    else
      render json: { errors: user.errors.full_messages.first }, status: 422
    end
  end

  # User is authenticated and is in the temporary, pre-confirmation
  # flow. Creates a user without an email or passowrd, and sets
  # `confirmed` to `false`. An access token is generated for the user.
  def create_temp
    user = User.new(confirmed: false)
    if user.save
      render json: user
    else
      render json: { errors: user.errors.full_messages.first }, status: 422
    end
  end

  private

  def registration_params
    params.require(:registration).permit(:email, :password)
  end
end
