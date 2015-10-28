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

FactoryGirl.define do
  factory :flat do
    title           { Forgery::LoremIpsum.title }
    address_line_1  { Forgery::Address.street_address }
    zip_code        { Forgery::Address.zip }
    city            { Forgery::Address.city }
    country         { Forgery::Address.country }
    rooms_number    { rand(0..10) }
    bed_number      { rand(0..10) }
    bathroom_number { rand(0..10) }
    people_number   { rand(0..10) }
    smoker          { [true, false].sample }
    television      { [true, false].sample }
    internet        { [true, false].sample }
    kind            { [:shared_room, :private_room, :all_flat].sample }
    price           { rand(20..1000) }
    latitude        { Forgery::Geo.latitude }
    longitude       { Forgery::Geo.longitude }

    association :owner, factory: :user
  end
end
