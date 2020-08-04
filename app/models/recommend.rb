class Recommend < ApplicationRecord
  belongs_to :user
  belongs_to :brand

	# scope :categorize, -> { includes(brand: :category).order('categories.name DESC')}
end
