class Admin::SlidersController < AdminController
  def index
    @sliders = Slider.order(created_at: :desc).page(params[:page]).per(50)
  end
end
