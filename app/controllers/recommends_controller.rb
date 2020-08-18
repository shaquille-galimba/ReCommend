class RecommendsController < ApplicationController
	before_action :set_recommend, only: [:show, :edit, :update, :destroy]

	def new
		if params[:brand_id]
			@brand = Brand.find_by_id(params[:brand_id])
			return page_not_found("Brand", brands_path) if !@brand
			@recommend = @brand.recommends.build
		elsif params[:category_id]
			@category = Category.find_by_id(params[:category_id])
			return page_not_found("Category", categories_path) if !@category
			@recommend = @category.brands.build.recommends.build
		else
			@recommend = Recommend.new
			@recommend.build_brand.build_category
		end
	end

	def create
		@recommend = current_user.recommends.build(comment: recommend_params[:comment])
		if params[:brand_id]
			@recommend.brand_id = recommend_params[:brand_id]
		else
			@recommend.brand_attributes = recommend_params[:brand_attributes]
			@category = @recommend.brand.category if params[:category_id]
		end

		if @recommend.save
			redirect_to recommend_path(@recommend)
		else
			render :new
		end
	end

	def index
		if params[:user_id]
			@user = User.find_by_id(params[:user_id])
			return page_not_found("User", users_path) if !@user
			@recommends = @user.recommends.latest.includes(brand: :category)
		else
			@recommends = Recommend.latest.includes(:user, brand: :category)
		end
		@recommends = @recommends.search(params[:q].downcase) if params[:q] && !params[:q].blank?
	end

	def show

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
		return page_not_found("Recommend", recommends_path) if !@recommend
	end
end
