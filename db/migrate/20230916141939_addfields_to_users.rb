class AddfieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :code_achat, :string
    add_column :users, :address, :string
  end
end
