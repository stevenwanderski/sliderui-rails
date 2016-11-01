if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_directory  = ENV['S3_BUCKET']
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['S3_KEY'],
      aws_secret_access_key: ENV['S3_SECRET'],
    }
  end
else
  CarrierWave.configure do |config|
    config.storage = :file
    config.asset_host = ActionController::Base.asset_host
  end
end
