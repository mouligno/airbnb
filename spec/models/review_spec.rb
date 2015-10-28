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

require 'rails_helper'

describe Review do
  subject(:review) { FactoryGirl.create(:review) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:flat) }
  it { is_expected.to allow_values(0, 1, 2, 3, 4, 5).for(:rating) }

  context 'denies review creation for flat owner' do
    review = FactoryGirl.create(:review)
    review.user = review.flat.owner
    review.save

    it { expect(review.errors.messages[:user]).to include "can't be the flat owner" }
  end
end
