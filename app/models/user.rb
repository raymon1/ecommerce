class User < ActiveRecord::Base
	GUEST_EXPIRE_IN = 24.hours

	before_destroy :delete_cart
	before_destroy :delete_session

	def delete_cart
		cart.cart_items.map(&:delete)
		cart.delete
	end

	def delete_session
		session[:guest_user_id]=nil
	end
end




