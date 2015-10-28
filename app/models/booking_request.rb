# == Schema Information
#
# Table name: booking_requests
#
#  id           :integer          not null, primary key
#  flat_id      :integer
#  requester_id :integer
#  description  :text
#  status       :string           default("pending")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  start_date   :date
#  end_date     :date
#

class BookingRequest < ActiveRecord::Base
  extend Enumerize

  belongs_to :flat
  belongs_to :requester, class_name: 'User', foreign_key: 'requester_id'

  validates_presence_of :flat,
                        :requester,
                        :description,
                        :start_date,
                        :end_date

  validate  :requester_cannot_be_flat_owner,
            :start_date_cannot_be_in_the_past,
            :end_date_cannot_be_before_start_date,
            :start_date_cannot_be_in_an_accepted_booking_request_period,
            :end_date_cannot_be_in_an_accepted_booking_request_period,
            :period_cannot_be_in_over_an_accepted_booking_request_period

  enumerize :status, in: [:pending, :accepted, :rejected], default: :pending

  scope :incoming_for, ->(user) { BookingRequest.joins(:flat).where(flats: { owner_id: user.id }) }

  scope :pending, -> { where(status: :pending) }
  scope :accepted, -> { where(status: :accepted) }
  scope :rejected, -> { where(status: :rejected) }

private

  def requester_cannot_be_flat_owner
    if requester == flat.owner
      errors.add(:requester, "can't be the owner")
    end
  end

  def start_date_cannot_be_in_the_past
    errors.add(:start_date, "can't be in the past") if
      !start_date.blank? and start_date < Date.today
  end

  def end_date_cannot_be_before_start_date
    errors.add(:end_date, "can't be before start date") if
      !end_date.blank? and end_date <= start_date
  end

  def start_date_cannot_be_in_an_accepted_booking_request_period
    if ['pending', 'accepted'].include?(status)
      flat_booking_requests = Flat.find(self.flat).booking_requests.accepted
      flat_booking_requests.each do |booking|
        errors.add(:period, "already booked") if
          start_date.between?(booking.start_date, booking.end_date - 1)
      end
    end
  end

  def end_date_cannot_be_in_an_accepted_booking_request_period
    if ['pending', 'accepted'].include?(status)
      flat_booking_requests = Flat.find(self.flat).booking_requests.accepted
      flat_booking_requests.each do |booking|
        errors.add(:period, "already booked") if
          end_date.between?(booking.start_date - 1, booking.end_date)
      end
    end
  end

  def period_cannot_be_in_over_an_accepted_booking_request_period
    if ['pending', 'accepted'].include?(status)
      flat_booking_requests = Flat.find(self.flat).booking_requests.accepted
      flat_booking_requests.each do |booking|
        errors.add(:period, "already booked") if
          start_date < booking.start_date && end_date > booking.end_date
      end
    end
  end
end
