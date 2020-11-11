source 'https://rubygems.org'

ruby '2.4.7'

gem 'rails', '4.2.8'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'

# Web server
gem 'puma', '3.7'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Pretty logging
gem 'awesome_print'

# Annotate ActiveRecord models to show
# the DB columns and relationships
gem 'annotate'

# JSON serializer
gem 'active_model_serializers', '~> 0.10.0'

# CORS config
gem 'rack-cors', require: 'rack/cors'

# File uploads
gem 'carrierwave', '>= 1.0.0.rc', '< 2.0'

# S3 storage
gem 'fog-aws'

# Test data
gem 'factory_girl_rails'

# Error reporting
gem 'sentry-raven'

# Authentication
gem 'devise'

# Pagination
gem 'kaminari'
gem 'bootstrap4-kaminari-views'

group :development, :test do
  gem 'quiet_assets'
  gem 'dotenv-rails'
  gem 'rspec-rails', '~> 3.0'
  gem 'pry-byebug'
end

group :test do
  gem 'database_cleaner'
  gem 'launchy'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'http_logger'
end

group :production do
  gem 'rails_12factor'
end
