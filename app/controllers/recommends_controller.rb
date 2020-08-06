class RecommendsController < ApplicationController

	def new
		@recommend = Recommend.new
		brand = @recommend.brand = Brand.new
		brand.category = Category.new
	end

	def index
		@recommends = Recommend.all
	end
end
