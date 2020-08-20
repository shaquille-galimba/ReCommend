class SessionsController < ApplicationController
	skip_before_action :require_login, only: [:new, :create, :omniauth]

	def new
		redirect_to recommends_path if logged_in?
	end

	def create
		@user = User.find_by(username: params[:user][:username])
		if @user && @user.authenticate(params[:user][:password])
			session[:user_id] = @user.id
			redirect_to recommends_path
		else
			flash[:alert] = "Invalid credentials."
			redirect_to login_path
		end
	end

	def destroy
		session.delete :user_id
		redirect_to login_path
	end

	def omniauth
		@user = User.find_or_create_by(email: auth[:info][:email]) do |user|
			user.username = auth[:info][:email].gsub("@gmail.com", "")
			user.first_name = auth[:info][:first_name]
			user.last_name = auth[:info][:last_name]
			user.password = SecureRandom.hex(8)
		end
		if @user.save
			session[:user_id] = @user.id
			redirect_to recommends_path
		else
			redirect_to login_path
		end
	end

	private

	def auth
		request.env['omniauth.auth']
	end
end
