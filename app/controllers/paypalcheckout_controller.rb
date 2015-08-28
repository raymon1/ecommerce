class PaypalcheckoutController < ApplicationController
	before_action :require_not_guest, only: [:create]
	protect_from_forgery except: [:hook]

	def create
		cart = Cart[session[:current_cart_id]]		
		paypal_payment = PaypalPayment.new(cart, '/galleries')

		if paypal_payment
			redirect_to paypal_payment.paypal_url
		else
			render :new
		end
	end

	def hook
		params.permit!
		

	end

end
