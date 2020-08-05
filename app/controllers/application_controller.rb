class ApplicationController < ActionController::Base
	helper_method :current_user, :logged_in?

	def current_user
		@current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
	end

	def logged_in?
		!!session[:user_id]
	end

	def require_logged_in
		return redirect_to login_path unless logged_in?
	end

	def index
		if logged_in?
			redirect_to user_path(current_user)
		else
			redirect_to login_path
		end
	end

end
