class User < ApplicationRecord
	has_many :recommends
	has_many :brands, through: :recommends
	has_many :categories, through: :brands
end
