source 'https://rubygems.org'

gem 'rails', '4.2.6'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'

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

group :development, :test do
  gem 'quiet_assets'
  gem 'dotenv-rails'
  gem 'rspec-rails', '~> 3.0'
  gem 'pry-byebug'
end

group :test do
  gem 'database_cleaner'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'launchy'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'http_logger'
end

group :production do
  gem 'rails_12factor'
end
