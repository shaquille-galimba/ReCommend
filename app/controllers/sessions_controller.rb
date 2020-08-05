class SessionsController < ApplicationController

	def new
		redirect_to user_path(current_user) if logged_in?
	end

	def create
		@user = User.find_by(username: params[:user][:username])
		if @user && @user.authenticate(params[:user][:password])
			session[:user_id] = @user.id
			redirect_to user_path(@user)
		else
			redirect_to login_path
		end
	end

	def destroy
		session.delete :user_id
		redirect_to login_path
	end

	def omniauth

	end

	private

	def auth
		request.env['omniauth.auth']
	end
end
