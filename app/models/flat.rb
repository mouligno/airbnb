class Flat < ActiveRecord::Base
  extend Enumerize

  attr_accessor :autocomplete_address

  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  has_many :booking_requests, dependent: :destroy

  validates_presence_of :address_line_1,
                        :bathroom_number,
                        :bed_number,
                        :city,
                        :country,
                        :kind,
                        :people_number,
                        :price,
                        :rooms_number,
                        :title,
                        :zip_code

  validates :bathroom_number, numericality: true
  validates :bed_number, numericality: true
  validates :people_number, numericality: true

  enumerize :kind, in: [:shared_room, :private_room, :all_flat]

  mount_uploaders :flat_pictures, FlatPictureUploader

  geocoded_by :full_address
  after_validation :geocode, if: :full_address_changed?

  def full_address
    "#{address_line_1} #{address_line_2}, #{zip_code} #{city} #{country}"
  end

  def full_address_changed?
    address_line_1_changed? || address_line_2_changed? || zip_code_changed? || city_changed? || country_changed?
  end
end
