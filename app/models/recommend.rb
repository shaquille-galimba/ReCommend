class Recommend < ApplicationRecord
  belongs_to :user
  belongs_to :brand

	scope :categorize, -> { includes(brand: :category).order('categories.name DESC')}

	def user_name
		user.username
	end

	def brand_name
		brand.name
	end
end
