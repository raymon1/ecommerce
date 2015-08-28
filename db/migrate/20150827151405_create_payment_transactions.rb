class CreatePaymentTransactions < ActiveRecord::Migration
  def change
    create_table :payment_transactions do |t|
    	t.string :status
    	t.string :transaction_id
    	

      t.timestamps
    end
  end
end
