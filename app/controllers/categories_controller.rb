class CategoriesController < ApplicationController

	def index
		@categories = Category.most_popular
		if params[:q] && !params[:q].empty?
			@categories = @categories.search(params[:q].downcase)
		end
	end

	def show
		if @category = Category.find_by_id(params[:id])
			@brands = @category.brands.most_popular
		else
			flash[:alert] = "Category not found"
			redirect_to categories_path
		end
	end
end
