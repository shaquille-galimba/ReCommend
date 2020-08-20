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
		@users = @users.search(params[:q].downcase) if params[:q] && !params[:q].blank?
	end

	def show
	end

	def edit
		authorize_user(@user)
	end

	def update
		if @user.update(user_params)
			redirect_to user_path(@user)
		else
			render :edit
		end
	end

	def destroy
		@user.destroy
		session.delete :user_id
		flash[:notice] = "Account successfully deleted"
		redirect_to login_path
	end

	private

	def user_params
		params.require(:user).permit(:email, :username, :first_name, :last_name, :password, :password_confirmation)
	end

	def set_user
		@user = User.find_by(id: params[:id])
		return page_not_found("User", users_path) if !@user
	end
end
