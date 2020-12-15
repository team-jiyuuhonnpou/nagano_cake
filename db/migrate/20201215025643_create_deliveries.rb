class CreateDeliveries < ActiveRecord::Migration[5.0]
  def change
    create_table :deliveries do |t|
      t.integer :customer_id
      t.string :name
      t.string :address
      t.string :postcode

      t.timestamps
    end
  end
end
