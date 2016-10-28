class SlidersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @slider = Slider.find(params[:id])

    @output = '<div class="slider">'
    @slider.slides.order(weight: :asc).each do |slide|
      @output += '<div class="slide">' + slide.content + '</div>'
    end
    @output += '</div>'

    respond_to do |format|
      format.js
    end
  end
end
