class Category < ApplicationRecord
	has_many :brands
	has_many :recommends, through: :brands
	# has_many :users, through: :brands

	scope :most_popular, -> {joins(:recommends).group('categories.id').order('count(categories.id) desc')}
end
