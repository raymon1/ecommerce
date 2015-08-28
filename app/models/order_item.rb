class OrderItem < ActiveRecord::Base
	belongs_to :order_items
	belongs_to :product

end
