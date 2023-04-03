class DashboardController < ApplicationController
  # before_action :authenticate_user!
  # before_action :ensure_subscription

  layout 'dashboard'

  private

  def ensure_subscription
    if current_user.subscription_type.blank?
      redirect_to dashboard_pricing_path
    end
  end
end
