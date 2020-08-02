class Category < ApplicationRecord
	has_many :brands
	has_many :recommends, through: :brands
end
