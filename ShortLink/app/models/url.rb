class Url < ActiveRecord::Base
  has_many :favorites
  has_many :user_favorites, through: :favorites, source: :user
  belongs_to :creator, class_name: "User"

  def self.get_short_url
  	SecureRandom.hex(5)
  end	
end