class RecommendsController < ApplicationController

	def new
		if params[:brand_id]
			if @brand = Brand.find_by_id(params[:brand_id])
				@recommend = @brand.recommends.build
			else
				flash[:alert] = "Brand not found"
				redirect_to brands_path
			end
		else
			@recommend = Recommend.new
			@recommend.build_brand.build_category
		end
	end

	def create
		@recommend = Recommend.new(comment: recommend_params[:comment])
		@recommend.user = current_user
		brand = @recommend.brand = Brand.find_or_create_by(name: recommend_params[:brand_attributes][:name])
		brand.category = Category.find_or_create_by(name: recommend_params[:brand_attributes][:category_attributes][:name]) unless brand.category

		if @recommend.save
			redirect_to recommend_path(@recommend)
		else
			render :new
		end
	end

	def show
		@recommend = Recommend.find_by(id: params[:id])
	end

	def index
		if params[:user_id]
			if user = User.find_by_id(params[:user_id])
				@recommends = user.recommends.latest
			else
				flash[:alert] = "User not found"
				redirect_to user_path(current_user)
			end
		else
			@recommends = Recommend.latest
		end
	end

	private

	def recommend_params
		params.require(:recommend).permit(
			:user,
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
