class FlatPictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :small do
    process resize_to_fill: [300, 200]
  end

  version :list do
    process resize_to_fill: [500, 333]
  end

  version :large do
    process resize_to_fit: [700, 10000]
  end
end
