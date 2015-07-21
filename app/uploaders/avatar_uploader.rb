class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_limit: [Settings.avatar.image_resize, 
    Settings.avatar.image_resize]

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    Settings.avatar.store_dir
  end

  def extension_white_list
    Settings.avatar.extension_white_list
  end
end
