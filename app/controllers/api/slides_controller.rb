class Api::SlidesController < ApiController
  def create
    slide = Slide.new(slide_params)
    if slide.save
      render json: slide
    else
      render json: { errors: slide.errors }, status: 422
    end
  end

  def update
    slide = Slide.find(params[:id])
    if slide.update(slide_params)
      render json: slide
    else
      render json: { errors: slide.errors }, status: 422
    end
  end

  def destroy
    slide = Slide.find(params[:id])
    if slide.destroy
      render json: slide
    else
      render json: { errors: slide.errors }, status: 422
    end
  end

  private

  def slide_params
    params.require(:slide).permit(:content, :weight, :slider_id)
  end
end
