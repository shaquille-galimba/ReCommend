class RecommendsController < ApplicationController

	def index
		@recommends = Recommend.all
	end
end
