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


require 'rails_helper'

describe Flat do
  it { is_expected.to belong_to(:owner) }
  it { is_expected.to have_many(:bookings) }
  it { is_expected.to have_many(:reviews) }
end
