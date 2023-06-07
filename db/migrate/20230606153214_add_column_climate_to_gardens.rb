class AddColumnClimateToGardens < ActiveRecord::Migration[7.0]
  def change
    add_column :gardens, :climate, :string
  end
end
