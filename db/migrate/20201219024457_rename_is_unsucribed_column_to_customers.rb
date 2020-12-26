class RenameIsUnsucribedColumnToCustomers < ActiveRecord::Migration[5.2]
  def change
    rename_column :customers, :is_unsucribed, :is_unsubscribed
  end
end
