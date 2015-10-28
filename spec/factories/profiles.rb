# == Schema Information
#
# Table name: profiles
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  description     :text
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  profile_picture :string
#

FactoryGirl.define do
  factory :profile do
    first_name  { Forgery::Name.first_name }
    last_name   { Forgery::Name.last_name }
    description { Forgery::LoremIpsum.paragraph }

    association :user
  end
end
