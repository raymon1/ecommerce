class GalleriesController < ApplicationController
	def index
		@products=Product.all
		@pictures=Picture.all
	end
end
