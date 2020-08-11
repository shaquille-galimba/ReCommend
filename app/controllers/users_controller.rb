class UsersController < ApplicationController
	skip_before_action :require_login, only: [:new, :create]
	before_action :set_user, only: [:show, :edit, :update, :destroy]


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

	def index
		@users = User.all
		if params[:q] && !params[:q].empty?
			@users = @users.search(params[:q].downcase)
		end
	end

	def show
		if !@user
			flash[:alert] = "User not found"
			redirect_to recommends_path
		end
	end

	def edit
		authorize_user(@user)
		if !@user
			flash[:alert] = "User not found"
			redirect_to recommends_path
		end
	end

	def update
		@user.update(user_params)
		redirect_to user_path(@user)
	end


	def destroy
		@user.destroy
		session.delete :user_id
		flash[:notice] = "Account successfully deleted"
		redirect_to login_path
	end

	private

	def user_params
		params.require(:user).permit(:email, :username, :password, :password_confirmation)
	end

	def set_user
		@user = User.find_by(id: params[:id])
	end
end
