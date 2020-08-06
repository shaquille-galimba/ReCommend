class BrandsController < ApplicationController

	def show
		@brand = Brand.find_by(id: params[:id])
	end
end
