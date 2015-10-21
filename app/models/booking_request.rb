class BookingRequest < ActiveRecord::Base
  extend Enumerize

  belongs_to :flat
  belongs_to :requester, class_name: 'User', foreign_key: 'requester_id'

  validates_presence_of :flat, :requester, :description

  validate :requester_cannot_be_flat_owner

  enumerize :status, in: [:pending, :accepted, :rejected], default: :pending

  scope :incoming_for, ->(user) { BookingRequest.joins(:flat).where(flats: { owner_id: user.id }) }

  private

  def requester_cannot_be_flat_owner
    if requester == flat.owner
      errors.add(:requester, "can't be the owner")
    end
  end
end
