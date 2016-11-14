class Api::SlidersController < ApiController
  def show
    slider = @current_user.sliders.find_by(id: params[:id])
    render json: slider
  end

  def create
    slider = @current_user.sliders.build(slider_params)
    if slider.save
      render json: { id: slider.id }
    else
      render json: { errors: slider.errors }, status: 422
    end
  end

  def update
    slider = @current_user.sliders.find_by(id: params[:id])
    slider.settings = params[:slider].delete(:settings)
    if slider.save
      render json: slider
    else
      render json: { errors: slider.errors }, status: 422
    end
  end

  def slides
    slider = @current_user.sliders.find_by(id: params[:id])
    render json: slider.slides.order(weight: :asc)
  end

  private

  def slider_params
    params.require(:slider).permit(:title, :settings)
  end
end
