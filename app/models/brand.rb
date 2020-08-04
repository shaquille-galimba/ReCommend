class Brand < ApplicationRecord
  belongs_to :category
	has_many :recommends
	has_many :users, through: :recommends

	# scope :list_by_category, -> (category) { where(category: category) }
end
