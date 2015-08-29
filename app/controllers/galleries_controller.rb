class GalleriesController < ApplicationController
	before_action :current_user
	helper_method :cartcount

	def cartcount
		if Cart[session[:current_cart_id]]
			@cu =  Cart[session[:current_cart_id]].quantity 
		else
			@cu =  0
		end
		@cu
	end

	def index
		@products=Product.all
		@pictures=Picture.all
				
		@c = session[:current_user_id]
		@carcount = cartcount
	end

end

