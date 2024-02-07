require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bxslider
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.generators do |generate|
      generate.helper false
      generate.assets false
      generate.view_specs false
    end

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'localhost:8080', 'localhost:8081', 'http://www.sliderui.com', 'https://www.sliderui.com'
        resource '*', :headers => :any, :methods => [:get, :post, :put, :delete, :options]
      end

      allow do
        origins '*'
        resource '/track', headers: :any, methods: :post
      end
    end

    config.to_prepare do
      Devise::Mailer.layout 'mailer'
    end

    config.active_record.legacy_connection_handling = false

    config.action_view.logger = nil
    config.assets.logger = false
    config.assets.quiet = true

    # config.hosts << ".ngrok-free.app"
  end
end
