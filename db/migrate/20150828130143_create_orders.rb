class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|

    	t.string :status #payment status
    	t.string :txn_id
    	t.datetime :payment_date
    	t.string :payment_method

    	t.string :firstname
    	t.string :lastname
    	t.string :address
    	t.string :city
    	t.string :country

    	t.integer :mc_gross
    	t.integer :mc_fee

      t.timestamps
    end
  end
end
