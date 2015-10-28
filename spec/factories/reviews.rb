# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  flat_id    :integer
#  rating     :integer
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


FactoryGirl.define do
  factory :review do
    flat
    user

    rating  { rand(1..5) }
    content { Forgery::LoremIpsum.paragraph }
  end
end
