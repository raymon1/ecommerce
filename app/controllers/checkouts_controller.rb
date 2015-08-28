class CheckoutsController < ApplicationController
	before_action :require_not_guest, only: [:index, :show]
	def create
		user = current_user
		user.update!(user_params)
		user.guest = "n"
		if user.save
			redirect_to '/checkouts', format: :html
		else
			render :new
		end
	end

	def new
	end

	def index		
	end

	private
	def user_params
		params.require(:user).permit(:email, :name, :address, :password, :phone, :country, :city)
	end
end