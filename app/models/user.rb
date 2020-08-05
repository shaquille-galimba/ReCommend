class User < ApplicationRecord
	has_secure_password
	validates :email, uniqueness: true
	validates :username, uniqueness: true
	has_many :recommends
	has_many :brands, through: :recommends
	has_many :categories, -> { distinct }, through: :brands
end
