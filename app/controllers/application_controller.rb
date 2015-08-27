class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :cartcount


  def current_user
  	@_current_user ||= session[:current_user_id] &&
  	User.find_by(id: session[:current_user_id])
  	if @_current_user != nil 
  		@_current_user
  	else 
  		@_current_user = create_guest_user
  	end
  	@_current_user
  end

  def current_user_id
  	return current_user[:id]
  end


  def create_guest_user
   if !session[:current_user_id].present?
        		gu = User.create(name: "Guest", email: "guest_#{Time.now.to_i}#@guest.com") # guest: true,
        		cart =Cart.create(user_id: gu.id, quantity: "0")
        		#ExpireGuestUsersWorker.perform_in(User::GUEST_EXPIRE_IN, gu.id)
           session[:current_user_id] = gu.id
           session[:current_cart_id] = cart.id
           puts"new session woooooooooooooooooooooow"
   end
  end

  def cartcount
    if Cart[session[:current_cart_id]]
      @cu =  Cart[session[:current_cart_id]].quantity 
    else
      @cu =  0
    end
    @cu
  end



end
