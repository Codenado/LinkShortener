class User < ActiveRecord::Base
	has_many :favorites
	has_many :created_urls, class_name: "Url", foreign_key: "creator_id"
	has_many :favorite_urls, through: :favorites, source: :url
	has_secure_password
	validates :email, presence: true, 
                  uniqueness: true,
                  format: {
                    with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9\.-]+\.[A-Za-z]+\Z/
                  }

	 before_validation :downcase_email				

	def downcase_email 
		self.email = email.downcase
	end		
end
