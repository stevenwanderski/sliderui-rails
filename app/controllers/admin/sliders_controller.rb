class Admin::SlidersController < ApplicationController
  def index
    @sliders = Slider.order(created_at: :desc).page(params[:page])
  end
end
