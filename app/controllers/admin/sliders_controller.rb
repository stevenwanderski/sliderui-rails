class Admin::SlidersController < ApplicationController
  def index
    @sliders = Slider.all
  end

  def show
    @slider = Slider.find(params[:id])
  end
end
