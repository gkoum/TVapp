# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end
  
  #def compose(width, height)
  #    first_image = MiniMagick::Image.open "first.jpg"
  #    second_image = MiniMagick::Image.open "second.jpg"
  #    result = first_image.composite(second_image) do |c|
  #      c.compose "Over" # OverCompositeOp
  #      c.geometry "+1+1" # copy second_image onto first_image from (20, 20)
  #    end
  #    result.write "output.jpg"
  #end
  process :auto_orient
  def auto_orient
    manipulate! do |img|
      img.auto_orient
      img
    end
  end
  # Create different versions of your uploaded files:
  version :thumb do
    process :auto_orient
    process :resize_to_limit => [300, 300]
   end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
