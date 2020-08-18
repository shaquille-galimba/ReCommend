class BrandsController < ApplicationController

	def show
		@brand = Brand.includes(recommends: :user).find_by(id: params[:id])
		if !@brand
			page_not_found("Brand", brands_path)
		end
	end

	def index
		@brands = Brand.most_popular
		# @categories = Category.all
		if params[:q] && !params[:q].blank?
			@brands = @brands.search(params[:q].downcase)
		end
	end
end
