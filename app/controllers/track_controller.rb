class TrackController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    slider = Slider.find_by(short_code: params[:short_code])

    TrackLog.create!(
      slider: slider,
      short_code: params[:short_code],
      url: params[:url]
    )

    head 201
  end
end