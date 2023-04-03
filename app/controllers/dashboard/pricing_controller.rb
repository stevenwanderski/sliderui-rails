class Dashboard::PricingController < DashboardController
  layout 'application'
  # skip_before_action :ensure_subscription
  # before_action :check_existing_subscription

  def index
  end

  def create
    current_user.update!(
      subscription_type: 'free',
      subscription_status: 'active'
    )

    redirect_to dashboard_sliders_path
  end

  private

  def check_existing_subscription
    if current_user.subscription_type.present?
      redirect_to dashboard_sliders_path
    end
  end
end
