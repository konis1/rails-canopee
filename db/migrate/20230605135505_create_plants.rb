class CreatePlants < ActiveRecord::Migration[7.0]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :color
      t.string :caducity
      t.integer :final_size
      t.integer :light_need
      t.integer :water_need
      t.integer :growth_speed
      t.integer :care_frequency
      t.integer :cold_resistance

      t.timestamps
    end
  end
end
