Rails.application.configure do
  config.lograge.enabled = Rails.env.production? || Rails.env.staging?
  # config.lograge.enabled = true

  config.lograge.formatter = Lograge::Formatters::Json.new

  config.lograge.custom_payload do |controller|
    exceptions = %w(controller action format id)
    {
      params: controller.request.filtered_parameters.except(*exceptions),
      user_id: controller.try(:current_user).try(:id),
      user_type: controller.try(:current_user).try(:class).try(:name)
    }
  end
end
