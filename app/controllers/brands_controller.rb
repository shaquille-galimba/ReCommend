class BrandsController < ApplicationController

	def show
		@brand = Brand.find_by(id: params[:id])
		if !@brand
			flash[:alert] = "Brand not found"
			redirect_to root_path
		end
	end

	def index
		@brands = Brand.all
	end
end
