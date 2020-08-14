class Recommend < ApplicationRecord
  belongs_to :user
  belongs_to :brand, counter_cache: true
	accepts_nested_attributes_for :brand
	delegate :category, :to => :brand

	# scope :categorize, -> { includes(brand: :category).order('categories.name DESC')}
	scope :latest, -> { order("updated_at DESC") }

	def self.search(params)
		left_joins(:brand => :category).left_joins(:user).where("LOWER(brands.name) LIKE :term OR LOWER(users.username) LIKE :term OR LOWER(categories.name) LIKE :term", term: "%#{params}%")
	end

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
