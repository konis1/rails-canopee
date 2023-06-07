class RemoveColorFromGarden < ActiveRecord::Migration[7.0]
  def change
    remove_column :gardens, :color, :string
  end
end
