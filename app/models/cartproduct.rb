class Cartproduct < Ohm::Model
	

	attribute :product_id
	attribute :amount
	attribute :price
	attribute :name

	reference :cart, :Cart

	index :product_id_cart_id
	unique :product_id_cart_id

	def product_id_cart_id
		"#{product_id}_#{cart_id}"
	end

	def productprice 
		price.to_f * amount.to_f
	end
	
end
