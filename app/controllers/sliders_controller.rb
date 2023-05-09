class SlidersController < ApplicationController
  include ActionView::Helpers::TagHelper
  skip_before_action :verify_authenticity_token

  def show
    @slider = Slider.find_by(short_code: params[:short_code])

    if @slider.v2? && @slider.user.blank?
      return render js: ''
    end

    begin
      RequestLog.create!(
        slider: @slider,
        user: @slider.user,
        referrer: request.referrer
      )
    rescue => e
      # Oops.
    end
  end
end
