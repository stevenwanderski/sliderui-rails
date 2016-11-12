class ApiController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  private

  def authenticate_user!
    authenticate_with_http_token do |token, options|
      return render_unauthorized unless token
      user = User.find_by(token: token)
      return render_unauthorized unless user
      @current_user = user
    end
  end

  def render_unauthorized
    render json: { errors: 'Unauthorized.' }, status: 401
  end
end
