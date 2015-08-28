class PaypalPayment 

	def initialize(cart, return_path)
		@values = {
			business: 'raymonmina-seller@gmail.com',
			cmd: '_cart',
		    upload: 1,
			return: "#{Rails.application.secrets.app_host}#{return_path}",
			notify_url: "#{Rails.application.secrets.app_host}/paypalcheckout/hook"}
			#:invoice => cart.id	
		
		cart.cartproducts.each_with_index do |item, index|
			@values.merge!({
				"amount_#{index+1}" => item.price,
				"item_name_#{index+1}" => item.name,
				"item_number_#{index+1}" => item.product_id,
				"quantity_#{index+1}" => item.amount
				})
		end
	end

	def paypal_url
		"#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + @values.to_query
	end

end