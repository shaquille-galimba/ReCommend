class User < ApplicationRecord
	has_secure_password
	validates :email, uniqueness: true
	validates :username, uniqueness: true
	validates :username, :email, presence: true
	validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true, :message => "can't have symbols"
	has_many :recommends, dependent: :delete_all
	has_many :brands, through: :recommends

	def self.search(params)
		where("LOWER(username) LIKE :term OR LOWER(email) LIKE :term", term: "%#{params}%")
	end

	def full_name
		first_name + " " + last_name if first_name && last_name
	end
end
