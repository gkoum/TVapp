class User < ActiveRecord::Base
  
  has_many :microposts, dependent: :destroy
  has_many :scenes
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }, 
                                    uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def scene_feed
    # This is preliminary. See "Following users" for the full implementation.
    Scene.where("user_id = ?", id)
  end
  
  def post_feed
      # This is preliminary. See "Following users" for the full implementation.
      Micropost.where("user_id = ?", id)
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  def self.search(search)
    where("name LIKE ? or username LIKE ?", "%#{search}%", "%#{search}%") 
    end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end
