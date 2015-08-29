class CartproductController < ApplicationController
	before_action :current_user

	def create 
		puts "creatinggggggggggggggggggggggggggggggggggggggggg"
		currentu = current_user
		productid = params[:cartproduct][:product_id]
		amount = params[:cartproduct][:amount]?  params[:cartproduct][:amount].to_i : 1 
		cart = Cart[session[:current_cart_id]]
		
		if cart===nil
			cart =Cart.create(user_id: currentu.id, quantity: "0")
			session[:current_cart_id] = cart.id
		end
		
		prod_id_cart_id = "#{productid}_#{cart.id}"
		
		cartproduct = Cartproduct.with(:product_id_cart_id, prod_id_cart_id)
		
		if cartproduct
			
			puts cartproduct.amount
			puts cart.quantity
			cart.quantity = (cart.quantity.to_i + amount - cartproduct.amount.to_i).to_s
			cartproduct.amount = amount		
						
		else			
			if amount >= 1
				cart.quantity = (cart.quantity.to_i + amount).to_s
				cartproduct = Cartproduct.create(product_id: productid,
					price: params[:cartproduct][:price],
					name: params[:cartproduct][:name],
					amount: amount,
					cart: cart)		

			end
		end
		
		cartproduct.save
		cart.save
		@cartcount = cartcount
		#redirect_to '/galleries'
		#format.js {render inline: "location.reload();" }
		#redirect_to :back
		render :new
	end
	

	def destroy
		puts "destroyingggggggggggggggggggggggggg"
		current_user
		cart = Cart[session[:current_cart_id]]
		productid = params[:cartproduct][:product_id]
		prod_id_cart_id = "#{productid}_#{cart.id}"		
		cartproduct = Cartproduct.with(:product_id_cart_id, prod_id_cart_id)
		if cartproduct && cart
			amount = cartproduct.amount.to_i
			puts amount+1
			cart.quantity = (cart.quantity.to_i - amount )
			cart.save
			cartproduct.delete
		end
		redirect_to '/galleries'
	end

	private
	def cartproduct_params
		require(:cartproduct).permit(:price, :name, :product_id, :amount)
	end
end
