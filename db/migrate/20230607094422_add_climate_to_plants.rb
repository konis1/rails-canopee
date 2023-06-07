class AddClimateToPlants < ActiveRecord::Migration[7.0]
  def change
    def change
      add_column :plants, :climate, :string, array: true
    end
  end
end
