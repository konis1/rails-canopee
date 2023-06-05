class CreateGardens < ActiveRecord::Migration[7.0]
  def change
    create_table :gardens do |t|
      t.string :name
      t.integer :light
      t.integer :size
      t.integer :care_willing
      t.string :location
      t.float :latitude
      t.float :longitude
      t.string :color
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
