class SlidersController < ApplicationController
  include ActionView::Helpers::TagHelper
  skip_before_action :verify_authenticity_token

  def show
    @short_code = params[:short_code]
    @slider = Slider.find_by(short_code: @short_code)
    @inactive_user = @slider.present? && @slider.user && !@slider.user.active?

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
