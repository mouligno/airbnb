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

class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :flat

  validates_presence_of :user, :flat, :content, :rating

  validates :rating, inclusion: { in: (0..5).to_a }, numericality: true

  validate  :user_cannot_be_flat_owner

private
  def user_cannot_be_flat_owner
    return false unless flat && user
    errors.add(:user, "can't be the flat owner") if
      user == flat.owner
  end
end
