class AddClimate < ActiveRecord::Migration[7.0]
  def change
    add_column :plants, :climate, :string, array: true
  end
end
