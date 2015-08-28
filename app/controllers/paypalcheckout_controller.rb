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
		order = Order.new(
			status: params[:payment_status],
	    	txn_id: params[:txn_id],
	    	payment_date: params[:payment_date],
	    	payment_method: "paypal",

	    	firstname: params[:first_name],
	    	lastname: params[:last_name],
	    	address: params[:address_street],
	    	city: params[:address_city],
	    	country: params[:address_country],

	    	mc_gross: params[:mc_gross].to_i,
	    	mc_fee: params[:mc_fee].to_i)

    	order.save

		n = params[:num_cart_items].to_i
		
    	if params[:num_cart_items] # && order[:status] = "completed"
    		for i in 1..n
    			order_item = OrderItem.new(amount: params["quantity#{i}"].to_i,
    					 product_id: params["item_number#{i}"].to_i,
    					 order_id: order.id)
    			puts i 
    			order_item.save	    				
    		end
    	end	   

	    render :nothing => true 	
	end



end
