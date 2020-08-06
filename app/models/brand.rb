class Brand < ApplicationRecord
  belongs_to :category
	has_many :recommends
	has_many :users, through: :recommends
	accepts_nested_attributes_for :category

	def category_name
		category.name
	end

	# scope :list_by_category, -> (category) { where(category: category) }
end
