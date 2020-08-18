class BrandsController < ApplicationController

	def show
		@brand = Brand.includes(recommends: :user).find_by(id: params[:id])
		if !@brand
			page_not_found("Brand", brands_path)
		end
	end

	def index
		@brands = Brand.most_popular
		@brands = @brands.search(params[:q].downcase) if params[:q] && !params[:q].blank?
	end
end
