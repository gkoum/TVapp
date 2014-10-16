class Micropost < ActiveRecord::Base

	mount_uploader :image, AvatarUploader
	belongs_to :user
	belongs_to :scene
	belongs_to :area
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :content, length: { maximum: 100 }

end
