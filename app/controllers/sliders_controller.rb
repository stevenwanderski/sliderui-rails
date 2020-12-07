class SlidersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    ap "REFERER: #{request.referrer}"

    @slider = Slider.find_by(short_code: params[:short_code])

    @output = '<div class="slider">'
    @slider.slides.order(weight: :asc).each do |slide|
      if slide.image.present?
        @output += '<div><img src="' + slide.image.url + '" /></div>'
      end
    end
    @output += '</div>'

    respond_to do |format|
      format.js
    end
  end
end
