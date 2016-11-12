class Api::UserSlidersController < ApiController
  def index
    sliders = @current_user.sliders
    render json: sliders
  end
end
