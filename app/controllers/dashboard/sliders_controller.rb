class Dashboard::SlidersController < DashboardController
  def create
    @slider = current_user.sliders.build(slider_params)

    if @slider.save
      redirect_to edit_dashboard_slider_path(@slider)
    else
      render 'new'
    end
  end

  def index
    @sliders = current_user.sliders
  end

  def edit
    @slider = current_user.sliders.find(params[:id])

    serializable_resource = ActiveModelSerializers::SerializableResource.new(@slider.slides)
    @slides = serializable_resource.as_json
  end

  def new
    @slider = current_user.sliders.build
  end

  def embed
    @slider = current_user.sliders.find(params[:slider_id])
  end

  private

  def slider_params
    params.require(:slider).permit(:title)
  end
end
