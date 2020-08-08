class ApplicationController < ActionController::Base
	helper_method :current_user, :logged_in?
	before_action :require_login


	def current_user
		@current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
	end

	def logged_in?
		!!session[:user_id]
	end

	private

	def require_login
    unless logged_in?
      flash[:alert] = "Log in or sign up to access that page"
      redirect_to login_path # halts request cycle
    end
  end

end
