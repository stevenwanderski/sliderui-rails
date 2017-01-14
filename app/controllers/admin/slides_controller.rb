class Admin::SlidesController < AdminController
  def index
    @slider = Slider.find(params[:slider_id])
    @slides = @slider.slides.order(created_at: :desc).page(params[:page]).per(10)
  end
end
