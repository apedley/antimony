# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  # Don't set this here.
  # it will ignore your environment based settings,
  # causing it to always upload to fog or to file
  # storage :file
  # storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  version :thumb do
    process :resize_and_pad => [140, 140]
  end
  version :large_thumb do
    process :resize_and_pad => [300, 300]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
