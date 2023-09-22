class AddAdditionalFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nom, :string
    add_column :users, :prenom, :string
    add_column :users, :adresse_ville, :string
    add_column :users, :adresse_type_voie, :string
    add_column :users, :adresse_nom_voie, :string
    add_column :users, :adresse_numero, :integer
    add_column :users, :adresse_code_postal, :integer
    add_column :users, :adresse_infos_complementaires_1, :string
    add_column :users, :adresse_infos_complementaires_2, :string
  end
end
