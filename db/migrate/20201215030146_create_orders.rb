class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :fee
      t.string :name
      t.string :address
      t.string :postcode
      t.integer :payment
      t.integer :payment_method
      t.integer :status

      t.timestamps
    end
  end
end
