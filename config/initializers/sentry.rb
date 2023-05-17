Sentry.init do |config|
  config.dsn = ENV['SENTRY_KEY']
  config.enabled_environments = %w[ production ]
end