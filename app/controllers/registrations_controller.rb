class RegistrationsController < Devise::RegistrationsController
  def new
    build_resource
    yield resource if block_given?

    plan_type = Subscription.get_plan(params[:plan])
    resource.subscription_type = plan_type
    assign_plan_meta(plan_type)

    respond_with resource
  end

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length

      plan_type = resource.subscription_type
      assign_plan_meta(plan_type)

      respond_with resource
    end
  end


  private

  def assign_plan_meta(plan_type)
    @plan_label = Subscription.get_label(plan_type)
    @plan_cost = Subscription.get_cost(plan_type)
  end

  def sign_up_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :subscription_type
    )
  end
end
