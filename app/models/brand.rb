class Brand < ApplicationRecord
  belongs_to :category
	has_many :recommends
	has_many :users, through: :recommends
	accepts_nested_attributes_for :category

	scope :most_popular, -> {joins(:recommends).group('brands.id').order('count(brands.id) desc')}
	scope :top_three, -> {joins(:recommends).group('brands.id').order('count(brands.id) desc').limit(3)}
	# scope :categorize, -> {joins(:category).order('categories.id')}

	def category_name
		category.name
	end

	def self.search(params)
		left_joins(:category).where("LOWER(brands.name) LIKE :term OR LOWER(categories.name) LIKE :term", term: "%#{params}%")
	end

	# scope :list_by_category, -> (category) { where(category: category) }
end
