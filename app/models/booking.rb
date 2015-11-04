# == Schema Information
#
# Table name: bookings
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

class Booking < ActiveRecord::Base
  include AASM
  include FlatAvaibility

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
            :start_date_cannot_be_in_an_booked_booking_period,
            :end_date_cannot_be_in_an_booked_booking_period,
            :period_cannot_be_in_over_an_booked_booking_period

  scope :incoming_for, ->(user) { Booking.joins(:flat).where(flats: { owner_id: user.id }) }

  scope :pending, -> { where(status: :pending) }
  scope :accepted, -> { where(status: :accepted) }
  scope :completed, -> { where(status: :completed) }
  scope :rejected, -> { where(status: :rejected) }
  scope :canceled, -> { where(status: :canceled) }
  scope :booked, -> { where(status: [:accepted, :completed]) }

  aasm column: :status do
    state :pending, initial: true
    state :accepted
    state :rejected
    state :completed
    state :canceled

    event :accept do
      after do
        ::Bookings::ToRequesterMailer.accept(self).deliver_now
      end
      transitions from: :pending, to: :accepted, guard: :flat_available?
    end

    event :reject do
      after do
        ::Bookings::ToRequesterMailer.reject(self).deliver_now
      end
      transitions from: :pending, to: :rejected
    end

    event :complete do
      after do
        ::Bookings::ToRequesterMailer.complete(self).deliver_now
        ::Bookings::ToOwnerMailer.complete(self).deliver_now
      end
      transitions from: :accepted, to: :completed
    end

    event :cancel do
      after do
        ::Bookings::ToRequesterMailer.cancel(self).deliver_now
        ::Bookings::ToOwnerMailer.cancel(self).deliver_now
      end
      transitions from: [:pending, :accepted], to: :canceled
    end

  end

private
  def flat_available?
    return false if start_date < Date.today

    flat_bookings = Flat.find(self.flat).bookings.booked
    flat_bookings.each do |booking|
      next if booking == self
      return false if start_date.between?(booking.start_date, booking.end_date - 1)
      return false if end_date.between?(booking.start_date - 1, booking.end_date)
      return false if start_date < booking.start_date && end_date > booking.end_date
    end

    true
  end

  def requester_cannot_be_flat_owner
    errors.add(:requester, "can't be the owner") if
      requester == flat.owner
  end

  def start_date_cannot_be_in_the_past
    errors.add(:start_date, "can't be in the past") if
      past?(start_date)
  end

  def end_date_cannot_be_before_start_date
    errors.add(:end_date, "can't be before start date") if
      past?(end_date, start_date)
  end

  def start_date_cannot_be_in_an_booked_booking_period
    if ['pending', 'accepted', 'completed'].include?(status)
      errors.add(:period, "already booked") if
        in_period?(start_date, self)
    end
  end

  def end_date_cannot_be_in_an_booked_booking_period
    if ['pending', 'accepted', 'completed'].include?(status)
      errors.add(:period, "already booked") if
        in_period?(end_date, self, false)
    end
  end

  def period_cannot_be_in_over_an_booked_booking_period
    if ['pending', 'accepted', 'completed'].include?(status)
      errors.add(:period, "already booked") if
        over_period?(self)
    end
  end
end
