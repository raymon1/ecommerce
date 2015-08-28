class Cart < Ohm::Model

	attribute :quantity
	attribute :user_id

	index :user_id
	unique :user_id

	collection :cartproducts, :Cartproduct

	def total_price
	    total = 0
	    self.cartproducts.each do |cp|
	      total += cp.productprice
	    end
	    @total_price ||= total
	end

  def count_cart_items
    count=0
    self.cartproducts.each do |cp|
      count = count + cp.amount.to_i
    end
    @total_count ||= count
  end





	def paypal_url(return_url)
  values = {
    :business => 'raymonmina-seller@gmail.com',
    :cmd => '_cart',
    :upload => 1,
    :return => return_url,
    :invoice => id
  }

  self.cartproducts.each_with_index do |item, index|
    values.merge!({
      "amount_#{index+1}" => item.price,
      "item_name_#{index+1}" => item.name,
      "item_number_#{index+1}" => item.id,
      "quantity_#{index+1}" => item.amount
    })
  end
  "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
end



end