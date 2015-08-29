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


end