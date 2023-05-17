class Admin::SlidersController < AdminController
  def index
    @sort = params[:sort] || 'date'
    @direction = params[:dir] || 'desc'

    @sliders = Slider
      .includes(:user)
      .references(:user)
      .where('users.id IS NOT NULL')
      .page(params[:page])
      .per(50)

    if @sort == 'date'
      @sliders = @sliders.order(created_at: @direction)
    elsif @sort == 'requests'
      @sliders = @sliders.order(request_logs_count: @direction)
    elsif @sort == 'tracks'
      @sliders = @sliders.order(track_logs_count: @direction)
    end
  end

  def show
    @slider = Slider.find(params[:id])
    @slides = @slider.slides.order(created_at: :desc).page(params[:page]).per(10)
  end
end
