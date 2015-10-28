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

FactoryGirl.define do
  factory :booking_request do
    flat
    association :requester, factory: :user

    description { Forgery::LoremIpsum.paragraph }
    start_date  { Forgery::Date.date(future: true) }
    end_date    { start_date + 4 }
  end
end
