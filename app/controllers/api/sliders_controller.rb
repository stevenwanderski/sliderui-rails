class Api::SlidersController < ApiController
  def show
    slider = current_user.sliders.find_by(id: params[:id])

    render json: slider
  end

  def update
    slider = current_user.sliders.find_by(id: params[:id])
    slider.settings = params[:slider].delete(:settings)
    
    if slider.save
      render json: slider
    else
      render json: { errors: slider.errors.full_messages.first }, status: 422
    end
  end

  private

  def slider_params
    params.require(:slider).permit(:title, :settings)
  end
end
