class Recommend < ApplicationRecord
  belongs_to :user
  belongs_to :brand
	accepts_nested_attributes_for :brand
	delegate :category, :to => :brand

	scope :categorize, -> { includes(brand: :category).order('categories.name DESC')}

	def user_name
		user.username
	end

	def brand_name
		brand.name
	end

	def category_name
		category.name
	end
end
