class CreateWishlistPlants < ActiveRecord::Migration[7.0]
  def change
    create_table :wishlist_plants do |t|
      t.references :wishlist, null: false, foreign_key: true
      t.references :plant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
