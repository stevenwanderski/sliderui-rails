class Admin::SlidersController < AdminController
  def index
    @sliders = Slider
      .order(created_at: :desc)
      .includes(:slides)
      .references(:slides)
      .where('slides.id IS NOT NULL')
      .page(params[:page])
      .per(50)
  end

  def show
    @slider = Slider.find(params[:id])
    @slides = @slider.slides.order(created_at: :desc).page(params[:page]).per(10)
  end
end
