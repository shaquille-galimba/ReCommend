class Category < ApplicationRecord
	has_many :brands
	has_many :recommends, through: :brands
	validates :name, presence: true

	scope :most_popular, -> {joins(:recommends).group('categories.id').order('count(categories.id) desc')}

	def self.search(params)
		where("LOWER(categories.name) LIKE :term", term: "%#{params}%")
	end
end
