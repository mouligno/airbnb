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

class Profile < ActiveRecord::Base
  belongs_to :user

  mount_uploader :profile_picture, ProfilePictureUploader
end
