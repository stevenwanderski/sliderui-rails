class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    resource.save

    if resource.persisted?
      resource.set_free_trial!
      UserMailer.with(user: resource).welcome_email.deliver_now
      UserMailer.with(user: resource).admin_notify.deliver_now

      sign_up(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  private

  def after_sign_up_path_for(resource)
    dashboard_sliders_path
  end
end
