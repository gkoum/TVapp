class Scene < ActiveRecord::Base

	belongs_to :user
	has_many :microposts
	has_many :areas
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	
  	def post_feed
    	# This is preliminary. See "Following users" for the full implementation.
    	Micropost.where("scene_id = ?", id)
  	end
  	def area_feed
    	# This is preliminary. See "Following users" for the full implementation.
    	@scene = Scene.where("id = ?", id)
      Area.all
  	end
    def self.search(search)
    where("name LIKE ?", "%#{search}%") 
    end
end
