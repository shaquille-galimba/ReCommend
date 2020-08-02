class Brand < ApplicationRecord
  belongs_to :category
	has_many :recommends
	has_many :users, through: :recommends
end
