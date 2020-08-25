class ApplicationController < ActionController::Base
	helper_method :current_user, :logged_in?
	before_action :require_login

	def current_user
		@current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
	end

	def logged_in?
		!!session[:user_id]
	end

	def authorize_user(user)
		unless user == current_user
			flash[:alert] = "Authorization Error!"
			redirect_to recommends_path
		end
	end

	def page_not_found(obj, path)
		flash[:alert] = "#{obj} not found"
		redirect_to path
	end

	private

	def require_login
    unless logged_in?
      flash[:alert] = "Log in or sign up to access that page"
      redirect_to login_path
    end
  end
end
