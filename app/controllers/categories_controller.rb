class CategoriesController < ApplicationController

	def index
		@categories = Category.most_popular
		@categories = @categories.search(params[:q].downcase) if params[:q] && !params[:q].blank?
	end

	def show
		@category = Category.find_by_id(params[:id])
		return page_not_found("Category", categories_path) if !@category
		@brands = @category.brands.most_popular
	end
end
