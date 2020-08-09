class RecommendsController < ApplicationController

	def new
		if params[:brand_id]
			if @brand = Brand.find_by_id(params[:brand_id])
				@recommend = @brand.recommends.build
			else
				flash[:alert] = "Brand not found"
				redirect_to brands_path
			end
		elsif params[:category_id]
			if @category = Category.find_by_id(params[:category_id])
				@recommend = @category.brands.build.recommends.build
			else
				flash[:alert] = "Category not found"
				redirect_to categories_path
			end
		else
			@recommend = Recommend.new
			@recommend.build_brand.build_category
		end
	end

	def create
		@recommend = current_user.recommends.build(comment: recommend_params[:comment])
		if params[:brand_id]
			@recommend.brand_id = recommend_params[:brand_id]
		elsif params[:category_id]
			brand = @recommend.brand = Brand.find_or_create_by(name: recommend_params[:brand_attributes][:name])
			brand.category = Category.find_by_id(recommend_params[:brand_attributes][:category_id])
		else
			brand = @recommend.brand = Brand.find_or_create_by(name: recommend_params[:brand_attributes][:name])
			brand.category = Category.find_or_create_by(name: recommend_params[:brand_attributes][:category_attributes][:name]) unless brand.category
		end

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
			:brand_id,
			:comment,
			brand_attributes: [
				:name,
				:category_id,
				category_attributes: [
					:name
				]
			]
		)
	end
end
