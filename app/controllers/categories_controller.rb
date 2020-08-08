class CategoriesController < ApplicationController

	def index
		@categories = Category.all
	end

	def show
		if @category = Category.find_by_id(params[:id])
			@brands = @category.brands.most_popular
		else
			flash[:alert] = "Category not found"
			redirect_to root_path
		end
	end
end
