class Dashboard::SlidersController < DashboardController
  def index
    @sliders = current_user.sliders
  end

  def edit
    @slider = current_user.sliders.find(params[:id])
  end

  def embed
    @slider = current_user.sliders.find(params[:slider_id])
  end
end
