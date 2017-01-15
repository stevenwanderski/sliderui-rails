class HomeController < ApplicationController
  before_action :check_admin

  def index
  end

  private

  def check_admin
    redirect_to admin_sliders_path if admin_signed_in?
  end
end
