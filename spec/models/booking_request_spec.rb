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

require 'rails_helper'

describe BookingRequest do
  subject(:booking_request) { FactoryGirl.create(:booking_request) }

  it { is_expected.to belong_to(:requester) }
  it { is_expected.to belong_to(:flat) }
  # it { is_expected.to validate_presence_of(:description) }
  # it { is_expected.to validate_presence_of(:start_date) }
  # it { is_expected.to validate_presence_of(:end_date) }

  context 'denies booking request creation for flat owner' do
    booking_request = FactoryGirl.create(:booking_request)
    booking_request.requester = booking_request.flat.owner
    booking_request.save

    it { expect(booking_request.errors.messages[:requester]).to include "can't be the owner" }
  end

  context 'start date cannot be in past' do
    booking_request = FactoryGirl.create(:booking_request)
    booking_request.start_date = Date.today - 1
    booking_request.save

    it { expect(booking_request.errors.messages[:start_date]).to include "can't be in the past" }
  end

  context 'end date cannot be before start date' do
    booking_request = FactoryGirl.create(:booking_request)
    booking_request.end_date = booking_request.start_date
    booking_request.save

    it { expect(booking_request.errors.messages[:end_date]).to include "can't be before start date" }
  end

  context 'denies booking request if start date in accepted booking request period' do
    booking_request_accepted        = FactoryGirl.create(:booking_request)
    booking_request_accepted.status = :accepted
    booking_request_accepted.save

    booking_request                 = FactoryGirl.create(:booking_request)
    booking_request.flat            = booking_request_accepted.flat
    booking_request.start_date      = booking_request_accepted.start_date + 1
    booking_request.end_date        = booking_request_accepted.end_date + 1
    booking_request.save

    it { expect(booking_request.errors.messages[:period]).to include "already booked" }
  end

  context 'denies booking request if period is over an accepted booking request period' do
    booking_request_accepted        = FactoryGirl.create(:booking_request)
    booking_request_accepted.status = :accepted
    booking_request_accepted.save

    booking_request                 = FactoryGirl.create(:booking_request)
    booking_request.flat            = booking_request_accepted.flat
    booking_request.start_date      = booking_request_accepted.start_date - 2
    booking_request.end_date        = booking_request_accepted.end_date + 2
    booking_request.save

    it { expect(booking_request.errors.messages[:period]).to include "already booked" }
  end

  context 'denies booking request if period is equal to an accepted booking request period' do
    booking_request_accepted        = FactoryGirl.create(:booking_request)
    booking_request_accepted.status = :accepted
    booking_request_accepted.save

    booking_request                 = FactoryGirl.create(:booking_request)
    booking_request.flat            = booking_request_accepted.flat
    booking_request.start_date      = booking_request_accepted.start_date
    booking_request.end_date        = booking_request_accepted.end_date
    booking_request.save

    it { expect(booking_request.errors.messages[:period]).to include "already booked" }
  end

  context 'denies booking request if period is inside an accepted booking request period' do
    booking_request_accepted        = FactoryGirl.create(:booking_request)
    booking_request_accepted.status = :accepted
    booking_request_accepted.save

    booking_request                 = FactoryGirl.create(:booking_request)
    booking_request.flat            = booking_request_accepted.flat
    booking_request.start_date      = booking_request_accepted.start_date + 1
    booking_request.end_date        = booking_request_accepted.end_date - 1
    booking_request.save

    it { expect(booking_request.errors.messages[:period]).to include "already booked" }

  end
end
