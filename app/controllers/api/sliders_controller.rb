class Api::SlidersController < ApiController
  def show
    slider = Slider.find(params[:id])
    render json: slider
  end

  def create
    slider = Slider.new(slider_params)
    if slider.save
      render json: slider
    else
      render json: { errors: slider.errors }, status: 422
    end
  end

  def slides
    slider = Slider.find(params[:id])
    render json: slider.slides.order(weight: :asc)
  end

  private

  def slider_params
    params.require(:slider).permit(:title)
  end
end
