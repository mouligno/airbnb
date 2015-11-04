# == Schema Information
#
# Table name: flats
#
#  id              :integer          not null, primary key
#  owner_id        :integer
#  title           :string
#  address_line_1  :string
#  address_line_2  :string
#  zip_code        :string
#  city            :string
#  country         :string
#  rooms_number    :integer
#  bed_number      :integer
#  bathroom_number :integer
#  people_number   :integer
#  smoker          :boolean
#  television      :boolean
#  internet        :boolean
#  kind            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  flat_pictures   :json
#  price           :float
#  latitude        :float
#  longitude       :float
#

class Flat < ActiveRecord::Base
  extend Enumerize
  paginates_per 8

  attr_accessor :autocomplete_address

  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_many :flat_pictures, inverse_of: :flat, dependent: :destroy
  accepts_nested_attributes_for :flat_pictures, allow_destroy: true

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

  geocoded_by :full_address
  after_validation :geocode, if: :full_address_changed?

  def full_address
    "#{address_line_1} #{address_line_2}, #{zip_code} #{city} #{country}"
  end

  def full_address_changed?
    address_line_1_changed? || address_line_2_changed? || zip_code_changed? || city_changed? || country_changed?
  end
end
