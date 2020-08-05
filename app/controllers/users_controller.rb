class UsersController < ApplicationController

	def index
		require_logged_in
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to user_path(@user)
		else
			render :new
		end
	end

	def show
		require_logged_in
		@user = User.find_by(id: params[:id])
	end

	private

	def user_params
		params.require(:user).permit(:email, :username, :password, :password_confirmation)
	end
end
