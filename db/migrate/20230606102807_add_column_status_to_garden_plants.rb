class AddColumnStatusToGardenPlants < ActiveRecord::Migration[7.0]
  def change
    add_column :garden_plants, :status, :integer, default: 0, index: true
  end
end
