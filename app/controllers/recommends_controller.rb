class RecommendsController < ApplicationController

	def new
		require_logged_in
		@recommend = Recommend.new
		@recommend.build_brand.build_category
	end

	def create
		@recommend = Recommend.new(recommend_params)
		@recommend.user = current_user
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
			user = User.find_by_id(params[:user_id])
			if user
				@recommends = user.recommends
			else
				flash[:alert] = "User not found"
				redirect_to root_path
			end
		else
			@recommends = Recommend.all
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
