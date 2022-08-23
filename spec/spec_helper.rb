ENV['RAILS_ENV'] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'

ActiveRecord::Migration[5.2].maintain_test_schema!
DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  include Warden::Test::Helpers
  config.include FactoryBot::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller

  Warden.test_mode!

  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
    FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads"])
    Warden.test_reset!
  end
end

Capybara.asset_host = 'http://localhost:3000/'

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :chrome
