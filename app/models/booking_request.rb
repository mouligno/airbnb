class BookingRequest < ActiveRecord::Base
  belongs_to :flat
  belongs_to :requester, class_name: 'User', foreign_key: 'requester_id'

  has_one :owner, through: :flat

  validates_presence_of :flat, :requester, :description

  validates :status, inclusion: %w(pending accepted rejected)
end
