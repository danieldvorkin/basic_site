class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 225 },
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }

	def User.digest(string)
		# assign the ActiveModel::SecurePassword minimum cost if there is, if not, assign the cost of the BCrypt::Engine
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost

		# Assign the BCrypt Password as a new string with cost assigned to the key cost
		BCrypt::Password.create(string, cost: cost)
	end
end