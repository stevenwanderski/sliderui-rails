class Dashboard::SlidersController < DashboardController
  def index
    @sliders = current_user.sliders
  end
end
