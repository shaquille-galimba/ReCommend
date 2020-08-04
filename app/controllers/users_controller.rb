class UsersController < ApplicationController

	def show
		require_logged_in
		@user = User.find_by(id: params[:id])
	end
end
