class BrandsController < ApplicationController

	def show
		@brand = Brand.includes(recommends: :user).find_by(id: params[:id])
		return page_not_found("Brand", brands_path) if !@brand
	end

	def index
		@brands = Brand.includes(:category).most_popular
		@brands = @brands.search(params[:q].downcase) if params[:q] && !params[:q].blank?
	end
end
