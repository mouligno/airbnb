class FlatPicture < ActiveRecord::Base
  belongs_to :flat,
              inverse_of: :flat_pictures,
              required: true

  mount_uploader :image, FlatPictureUploader
end
