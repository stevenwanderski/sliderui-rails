class RegistrationsController < Devise::RegistrationsController
  private

  def after_sign_up_path_for(resource)
    dashboard_sliders_path
  end
end
