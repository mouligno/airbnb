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

require 'rails_helper'

describe Booking do
  subject(:booking) { FactoryGirl.create(:booking) }

  it { is_expected.to belong_to(:requester) }
  it { is_expected.to belong_to(:flat) }
  # it { is_expected.to validate_presence_of(:description) }
  # it { is_expected.to validate_presence_of(:start_date) }
  # it { is_expected.to validate_presence_of(:end_date) }

  context 'denies booking request creation for flat owner' do
    booking = FactoryGirl.create(:booking)
    booking.requester = booking.flat.owner
    booking.save

    it { expect(booking.errors.messages[:requester]).to include "can't be the owner" }
  end

  context 'start date cannot be in past' do
    booking = FactoryGirl.create(:booking)
    booking.start_date = Date.today - 1
    booking.save

    it { expect(booking.errors.messages[:start_date]).to include "can't be in the past" }
  end

  context 'end date cannot be before start date' do
    booking = FactoryGirl.create(:booking)
    booking.end_date = booking.start_date
    booking.save

    it { expect(booking.errors.messages[:end_date]).to include "can't be before start date" }
  end

  context 'denies booking request if start date in accepted booking request period' do
    booking_accepted        = FactoryGirl.create(:booking)
    booking_accepted.status = :accepted
    booking_accepted.save

    booking                 = FactoryGirl.create(:booking)
    booking.flat            = booking_accepted.flat
    booking.start_date      = booking_accepted.start_date + 1
    booking.end_date        = booking_accepted.end_date + 1
    booking.save

    it { expect(booking.errors.messages[:period]).to include "already booked" }
  end

  context 'denies booking request if period is over an accepted booking request period' do
    booking_accepted        = FactoryGirl.create(:booking)
    booking_accepted.status = :accepted
    booking_accepted.save

    booking                 = FactoryGirl.create(:booking)
    booking.flat            = booking_accepted.flat
    booking.start_date      = booking_accepted.start_date - 2
    booking.end_date        = booking_accepted.end_date + 2
    booking.save

    it { expect(booking.errors.messages[:period]).to include "already booked" }
  end

  context 'denies booking request if period is equal to an accepted booking request period' do
    booking_accepted        = FactoryGirl.create(:booking)
    booking_accepted.status = :accepted
    booking_accepted.save

    booking                 = FactoryGirl.create(:booking)
    booking.flat            = booking_accepted.flat
    booking.start_date      = booking_accepted.start_date
    booking.end_date        = booking_accepted.end_date
    booking.save

    it { expect(booking.errors.messages[:period]).to include "already booked" }
  end

  context 'denies booking request if period is inside an accepted booking request period' do
    booking_accepted        = FactoryGirl.create(:booking)
    booking_accepted.status = :accepted
    booking_accepted.save

    booking                 = FactoryGirl.create(:booking)
    booking.flat            = booking_accepted.flat
    booking.start_date      = booking_accepted.start_date + 1
    booking.end_date        = booking_accepted.end_date - 1
    booking.save

    it { expect(booking.errors.messages[:period]).to include "already booked" }

  end
end
