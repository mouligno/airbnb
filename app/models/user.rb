class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile, dependent: :destroy
  has_many :flats, foreign_key: :owner_id, dependent: :destroy
  has_many :booking_requests, foreign_key: :requester_id, dependent: :destroy
end