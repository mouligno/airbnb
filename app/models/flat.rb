class Flat < ActiveRecord::Base
  belongs_to :user, foreign_key: 'owner_id'

  validates_presence_of :address_line_1,
                        :bathroom_number,
                        :bed_number,
                        :city,
                        :country,
                        :kind,
                        :people_number,
                        :rooms_number,
                        :title,
                        :zip_code

  validates :bathroom_number, numericality: true
  validates :bed_number, numericality: true
  validates :people_number, numericality: true

  validates :kind, inclusion: { in: ["Shared room", "Private room", "Full flat"] }

  mount_uploaders :flat_pictures, FlatPictureUploader
end
