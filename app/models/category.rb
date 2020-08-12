class Category < ApplicationRecord
	has_many :brands
	has_many :recommends, through: :brands
	# has_many :users, through: :brands
end
