class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    resource.save

    if resource.persisted?
      resource.set_free_trial!
      slider = resource.sliders.create!

      begin
        UserMailer.with(user: resource).welcome_email.deliver_now
        UserMailer.with(user: resource).admin_notify.deliver_now
      rescue => e
        Sentry.capture_exception(e)
      end

      sign_up(resource_name, resource)
      respond_with resource, location: dashboard_edit_slider_path(short_code: slider.short_code)
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
