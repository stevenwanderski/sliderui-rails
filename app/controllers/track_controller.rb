class TrackController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    TrackLog.create!(
      short_code: params[:short_code],
      url: params[:url]
    )
  end
end