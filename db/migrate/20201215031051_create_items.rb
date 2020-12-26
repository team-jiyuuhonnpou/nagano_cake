class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.integer :genre_id
      t.string :item_name
      t.text :explanation
      t.string :image_id
      t.integer :non_taxed_price
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
