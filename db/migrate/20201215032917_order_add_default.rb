class OrderAddDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :orders, :payment_method, from: "", to: 0
    change_column_default :orders, :status, from: "", to: 0
  end
end
