FactoryBot.define do
  factory :slide do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'dags.jpg')) }
  end
end
