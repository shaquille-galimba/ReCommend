class RecommendsController < ApplicationController

	def new
		@recommend = Recommend.new
		@recommend.build_brand.build_category
	end

	def create

	end

	def show
		@recommend = Recommend.find_by(id: params[:id])
	end

	def index
		@recommends = Recommend.all
	end

	private

	def recommend_params
		params.require(:recommend).permit(
			:comment,
			brand_attributes: [
				:name,
				category_attributes: [
					:name
				]
			]
		)
	end
end
