class User < ApplicationRecord
	has_secure_password
	has_many :recommends
	has_many :brands, through: :recommends
	has_many :categories, -> { distinct }, through: :brands

	def full_name
		first_name + ' ' + last_name
	end
end
