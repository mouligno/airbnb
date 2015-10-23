class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :flat

  validates_presence_of :user, :flat, :content, :rating

  validates :rating, inclusion: { in: (0..5).to_a }, numericality: true

  validate  :user_cannot_be_flat_owner

private
  def user_cannot_be_flat_owner
    errors.add(:user, "can't be the flat owner") if
      user == flat.owner
  end
end
