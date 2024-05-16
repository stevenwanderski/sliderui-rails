class Dashboard::Sliders::SlidesController < DashboardController
  def new
    @slider = current_user.sliders.find_by(short_code: params[:short_code])
    @slide = Slide.new
  end

  def create
    @slider = current_user.sliders.find_by(short_code: params[:short_code])
    @slide = @slider.slides.new(slide_params)

    if @slide.save
      redirect_to dashboard_edit_slider_path(@slider.short_code)
    else
      render :new
    end
  end

  def edit
    @slider = current_user.sliders.find_by(short_code: params[:short_code])
    @slide = @slider.slides.find(params[:id])
  end

  def update
    @slider = current_user.sliders.find_by(short_code: params[:short_code])
    @slide = @slider.slides.find(params[:id])

    if @slide.update(slide_params)
      redirect_to dashboard_edit_slider_path(@slider.short_code), notice: 'Slide updated.'
    else
      render :edit
    end
  end

  private

  def slide_params
    params.require(:slide).permit(:image, :url)
  end
end
