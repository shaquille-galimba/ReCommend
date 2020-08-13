class RecommendsController < ApplicationController
	before_action :set_recommend, only: [:show, :edit, :update, :destroy]

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

	def index
		if params[:user_id]
			if @user = User.find_by_id(params[:user_id])
				@recommends = @user.recommends.latest
			else
				flash[:alert] = "User not found"
				redirect_to user_path(current_user)
			end
		else
			@recommends = Recommend.latest.includes(:user, brand: :category)
		end

		if params[:q] && !params[:q].empty?
			@recommends = @recommends.search(params[:q].downcase)
		end
	end

	def show
		if !@recommend
			flash[:alert] = "Recommendation not found"
			redirect_to recommends_path
		end
	end


	def edit
		authorize_user(@recommend.user)
	end

	def update
		@recommend.update(recommend_params)
		flash[:notice] = "Updated successfully"
		redirect_to recommend_path(@recommend)
	end

	def destroy
		@recommend.destroy
		redirect_to recommends_path
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

	def set_recommend
		@recommend = Recommend.find_by(id: params[:id])
	end
end
