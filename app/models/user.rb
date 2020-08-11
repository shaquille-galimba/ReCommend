class User < ApplicationRecord
	has_secure_password
	validates :email, uniqueness: true
	validates :username, uniqueness: true
	validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
	has_many :recommends, dependent: :delete_all
	has_many :brands, through: :recommends
	has_many :categories, -> { distinct }, through: :brands
end
