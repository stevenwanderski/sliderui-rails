class Dashboard::SlidersController < DashboardController
  def index
    @sliders = current_user.sliders
  end

  def edit
    @slider = Slider.find_by(short_code: params[:short_code])
    @slides = @slider.slides
    @modal_open = params[:install] == 'true'

    if !current_user
      @user = User.new
    end
  end

  def update
    @slider = Slider.find_by(short_code: params[:short_code])
    @slider.update!(slider_params)
  end

  def new
    if current_user
      @slider = current_user.sliders.create!(version: 2)
    else
      @slider = Slider.create!(version: 2)
    end

    redirect_to dashboard_edit_slider_path(@slider.short_code)
  end

  def destroy
    @slider = current_user.sliders.find_by(short_code: params[:short_code])
    @slider.destroy!
    redirect_to dashboard_sliders_path, notice: "Slider #{@slider.short_code} was deleted."
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

  def user_create
    @user = User.new(user_params)
    @slider = Slider.find_by(short_code: params[:short_code])

    if @user.save
      @slider.update!(user: @user)
      sign_in(@user)
    else
      render 'user_create_error'
    end
  end

  def session_create
    @slider = Slider.find_by(short_code: params[:short_code])
    @user = User.find_by(email: user_params[:email])

    if @user.nil?
      @user = User.new(user_params)
      @session_error = 'Invalid email or password'
      return render 'session_create_error'
    end

    if !@user.valid_password?(user_params[:password])
      @user = User.new(user_params)
      @session_error = 'Invalid email or password'
      return render 'session_create_error'
    end

    @slider.update!(user: @user)
    sign_in(@user)
  end

  private

  def slider_params
    params.require(:slider).permit!
  end

  def slide_params
    params.require(:slide).permit(:content, :weight, :image, :slider_id)
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
