class SlideImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_allowlist
    %w(jpg jpeg png)
  end

  def content_type_allowlist
    /image\//
  end

  def size_range
    1.byte..2.megabytes
  end

  process :resize_to_limit => [2000, 2000]
end
