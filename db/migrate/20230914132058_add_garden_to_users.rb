class AddGardenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :garden, null: true, foreign_key: true
  end
end
