class RemoveFieldsFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :adresse_type_voie, :string
    remove_column :users, :adresse_nom_voie, :string
    remove_column :users, :adresse_numero, :integer
  end
end
