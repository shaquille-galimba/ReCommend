class RecommendsController < ApplicationController
	before_action :set_recommend, only: [:show, :edit, :update, :destroy]

	def new
		if params[:brand_id]
			if @brand = Brand.find_by_id(params[:brand_id])
				@recommend = @brand.recommends.build
			else
				page_not_found("Brand", brands_path)
			end
		elsif params[:category_id]
			if @category = Category.find_by_id(params[:category_id])
				@recommend = @category.brands.build.recommends.build
			else
				page_not_found("Category", categories_path)
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
			if @user = User.find_by_id(params[:user_id])
				@recommends = @user.recommends.latest.includes(brand: :category)
			else
				page_not_found("User", users_path)
			end
		else
			@recommends = Recommend.latest.includes(:user, brand: :category)
		end

		if params[:q] && !params[:q].blank?
			@recommends = @recommends.search(params[:q].downcase)
		end
	end

	def show
		if !@recommend
			page_not_found("Recommend", recommends_path)
		end
	end


	def edit
		if @recommend
			authorize_user(@recommend.user)
		else
			page_not_found("Recommend", recommends_path)
		end
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
