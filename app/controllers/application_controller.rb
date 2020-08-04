class ApplicationController < ActionController::Base
	helper_method :current_user

	def current_user
		@user = User.find_by(id: session[:user_id])
	end

	def logged_in?
		current_user != nil
	end

	def require_logged_in
		return redirect_to login_path unless logged_in?
	end

	def welcome

	end

end
