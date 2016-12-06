Raven.configure do |config|
  config.dsn = 'https://eb6a0dd9416c4ba1937e58bf9f787fbd:1e5dcc1a732340d1ab7ed5225d1301d4@sentry.io/120008'
  config.environments = %w[ production ]
  config.processors -= [Raven::Processor::PostData]
end
