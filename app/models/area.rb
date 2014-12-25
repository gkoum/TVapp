class Area < ActiveRecord::Base

	belongs_to :scene
	belongs_to :template
	has_many :microposts
	default_scope -> { order('created_at DESC') }
	validates :scene_id, presence: true

	def post_feed
    	# This is preliminary. See "Following users" for the full implementation.
    	Micropost.where("area_id = ?", id)
  	end
end
