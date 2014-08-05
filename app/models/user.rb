class User < ActiveRecord::Base
  has_attached_file :avatar, 
    default_url: "",
    styles: {
      medium: "300x300#",
      thumbnail: "75x75#",
    }

  validates_attachment :avatar, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates :user_name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password_digest, presence: true
end
