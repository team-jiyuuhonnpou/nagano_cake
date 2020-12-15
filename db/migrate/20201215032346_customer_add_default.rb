class CustomerAddDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :customers, :is_unsucribed, from: "", to: false
  end
end
