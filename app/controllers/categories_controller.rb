class CategoriesController < ApplicationController

	def index
		@categories = Category.most_popular
		@categories = @categories.search(params[:q].downcase) if params[:q] && !params[:q].blank?
	end

	def show
		if @category = Category.find_by_id(params[:id])
			@brands = @category.brands.most_popular
		else
			page_not_found("Category", categories_path)
		end
	end
end
