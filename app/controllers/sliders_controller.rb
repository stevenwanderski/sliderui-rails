class SlidersController < ApplicationController
  include ActionView::Helpers::TagHelper
  skip_before_action :verify_authenticity_token

  def show
    @slider = Slider.find_by(short_code: params[:short_code])

    ap request.referrer

    # begin
    #   RequestLog.create!(
    #     slider: @slider,
    #     user: @slider.user,
    #     referrer: request.referrer
    #   )
    # rescue => e
    #   # Oops.
    # end

    if @slider.restricted?
      @output = content_tag(:p,
        'This SliderUI image gallery is only available with the premium plan.',
        style: 'background: #f5f5f5; padding: 20px; border: solid #ccc 1px; text-align: center;'
      )
    else
      @output = '<div class="slider">'
      @slider.slides.each do |slide|
        if slide.image.present?
          @output += '<div><img src="' + slide.image.url + '" /></div>'
        end
      end
      @output += '</div>'
    end

    respond_to do |format|
      format.js
    end
  end
end
