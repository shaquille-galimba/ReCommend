class UsersController < ApplicationController
	skip_before_action :require_login, only: [:new, :create]

	def index
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to recommends_path
		else
			render :new
		end
	end

	def edit
		@user = User.find_by(id: params[:id])
		if !@user
			flash[:alert] = "User not found"
			redirect_to recommends_path
		end
	end

	def update
		@user = User.find_by(id: params[:id])
		@user.update(user_params)
		redirect_to user_path(@user)
	end

	def show
		@user = User.find_by(id: params[:id])
		if !@user
			flash[:alert] = "User not found"
			redirect_to recommends_path
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :username, :password, :password_confirmation)
	end
end
