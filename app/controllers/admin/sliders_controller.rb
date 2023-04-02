class Admin::SlidersController < AdminController
  def index
    @sliders = Slider.order(created_at: :desc).page(params[:page]).per(50)
  end

  def by_request_logs
    @sliders = Slider.order(request_logs_count: :desc).page(params[:page]).per(50)
  end
end
