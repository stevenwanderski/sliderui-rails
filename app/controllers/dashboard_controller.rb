class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_subscription

  layout 'dashboard'

  private

  def ensure_subscription
    return if current_user.active?

    @checkout_url = dashboard_subscription_checkout_path
  end
end
