class User < ActiveRecord::Base
	validates :email, presence: true, length: { maximum: 50 }
	validates :name, presence: true, length: { maximum: 225 }
	validates :password, presence: true, length: { minimum: 6 }
	has_secure_password
end