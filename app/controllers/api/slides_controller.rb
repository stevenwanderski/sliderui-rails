class Api::SlidesController < ApiController
  # KEEP
  def create
    if !owns_slider?(slide_params[:slider_id])
      return render json: { errors: 'Forbidden' }, status: 401
    end

    slide = Slide.new(slide_params)
    if slide.save
      render json: slide
    else
      render json: { errors: slide.errors.full_messages.first }, status: 422
    end
  end

  # KEEP
  def destroy
    slide = Slide.find(params[:id])

    if !owns_slide?(slide)
      return render json: { errors: 'Forbidden' }, status: 401
    end

    if slide.destroy
      render json: slide
    else
      render json: { errors: slide.errors.full_messages.first }, status: 422
    end
  end

  # KEEP
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

  def owns_slider?(slider_id)
    slider = Slider.find(slider_id)
    current_user.id == slider.user_id
  end

  def owns_slide?(slide)
    current_user.id == slide.slider.user_id
  end
end
