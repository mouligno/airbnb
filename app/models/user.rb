class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :profile, dependent: :destroy
  has_many :flats, foreign_key: :owner_id, dependent: :destroy
  has_many :booking_requests, foreign_key: :requester_id, dependent: :destroy
  has_many :guest_requests, through: :flats, source: :booking_requests
  has_many :reviews, dependent: :destroy

  after_create :set_profile

  private
    def set_profile
      self.profile = self.build_profile
    end
end
