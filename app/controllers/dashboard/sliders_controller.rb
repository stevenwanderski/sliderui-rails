class Dashboard::SlidersController < DashboardController
  def index
    @sliders = current_user.sliders
  end

  def edit
    @slider = current_user.sliders.find_by(short_code: params[:short_code])
    @slides = @slider.slides
  end

  def update
    @slider = current_user.sliders.find_by(short_code: params[:short_code])
    @slider.update!(slider_params)
  end

  def new
    @slider = current_user.sliders.create!

    redirect_to dashboard_edit_slider_path(@slider.short_code)
  end

  def destroy
    @slider = current_user.sliders.find_by(short_code: params[:short_code])
    @slider.destroy!
    redirect_to dashboard_sliders_path, notice: "Slider #{@slider.short_code} was deleted."
  end

  def slide_destroy
    slide = Slide.find(params[:slide_id])
    slide.destroy!

    @slider = current_user.sliders.find_by(short_code: params[:short_code])
    @slides = @slider.slides
  end

  def slides_update
    params[:slides].each_with_index do |slide_id, index|
      slide = Slide.find(slide_id)

      slide.update!(weight: index)
    end

    @slider = current_user.sliders.find_by(short_code: params[:short_code])
    @slides = @slider.slides
  end

  private

  def slider_params
    params.require(:slider).permit!
  end

  def slide_params
    params.require(:slide).permit(:content, :weight, :image, :slider_id)
  end
end
