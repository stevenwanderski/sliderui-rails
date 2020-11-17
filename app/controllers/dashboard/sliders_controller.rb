class Dashboard::SlidersController < DashboardController
  def index
    @sliders = current_user.sliders
  end

  def edit
    @slider = current_user.sliders.find(params[:id])

    serializable_resource = ActiveModelSerializers::SerializableResource.new(@slider.slides)
    @slides = serializable_resource.as_json
  end

  def embed
    @slider = current_user.sliders.find(params[:slider_id])
  end
end
