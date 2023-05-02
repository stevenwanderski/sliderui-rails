class Dashboard::SlidersController < DashboardController
  # before_action :ensure_subscription_type!, only: [:create, :new]

  def create
    @slider = current_user.sliders.build(slider_params)

    if @slider.save
      redirect_to edit_dashboard_slider_path(@slider)
    else
      render 'new'
    end
  end

  def index
    @unrestricted_sliders = current_user.sliders_unrestricted
    @restricted_sliders = current_user.sliders_restricted
  end

  def edit
    # @slider = current_user.sliders.find(params[:id])
    @slider = Slider.find_by(short_code: params[:short_code])
    @slides = @slider.slides
  end

  def update
    @slider = Slider.find_by(short_code: params[:short_code])
    @slider.update!(slider_params)
  end

  def new
    # @slider = current_user.sliders.build
    @slider = Slider.create!
    redirect_to dashboard_edit_slider_path(@slider.short_code)
  end

  def destroy
    @slider = current_user.sliders.find(params[:id])
    @slider.destroy!
    redirect_to dashboard_sliders_path, notice: "Slider \"#{@slider.title}\" was deleted."
  end

  def embed
    @slider = Slider.find_by(short_code: params[:short_code])
  end

  def slide_create
    slide = Slide.create!(slide_params)

    @slider = Slider.find_by(short_code: params[:short_code])
    @slides = @slider.slides
  end

  def slide_destroy
    slide = Slide.find(params[:slide_id])
    slide.destroy!

    @slider = Slider.find_by(short_code: params[:short_code])
    @slides = @slider.slides
  end

  def slides_update
    params[:slides].each_with_index do |slide_id, index|
      slide = Slide.find(slide_id)

      slide.update!(weight: index)
    end

    @slider = Slider.find_by(short_code: params[:short_code])
    @slides = @slider.slides
  end

  private

  def ensure_subscription_type!
    if !current_user.can_add_slider?
      redirect_to edit_dashboard_subscription_path
    end
  end

  def slider_params
    params.require(:slider).permit!
  end

  def slide_params
    params.require(:slide).permit(:content, :weight, :image, :slider_id)
  end
end
