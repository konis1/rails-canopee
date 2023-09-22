class AddPlacedOrderColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :placed_order, :boolean, default: false
  end
end
