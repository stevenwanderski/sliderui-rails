class Api::SlidesController < ApiController
  def create
    slide = Slide.new(slide_params)
    if slide.save
      render json: slide
    else
      render json: { errors: slide.errors.full_messages.first }, status: 422
    end
  end

  def update
    slide = Slide.find(params[:id])
    if slide.update(slide_params)
      render json: slide
    else
      render json: { errors: slide.errors.full_messages.first }, status: 422
    end
  end

  def destroy
    slide = Slide.find(params[:id])
    if slide.destroy
      render json: slide
    else
      render json: { errors: slide.errors.full_messages.first }, status: 422
    end
  end

  def update_collection
    params[:slides].each do |slide|
      Slide.where(id: slide['id']).update_all(weight: slide['weight'])
    end
    render nothing: true, status: 200
  end

  private

  def slide_params
    params.require(:slide).permit(:content, :weight, :image, :slider_id)
  end
end
