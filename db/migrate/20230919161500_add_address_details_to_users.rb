class AddAddressDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :adresse_numero, :string
    add_column :users, :adresse_type_voie, :string
    add_column :users, :adresse_nom_voie, :string
  end
end
