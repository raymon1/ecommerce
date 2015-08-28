class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :name
    	t.string :email
    	t.string :phone
    	t.string :address
    	t.string :country
    	t.string :city
      t.string :guest

      t.timestamps
    end
  end
end
