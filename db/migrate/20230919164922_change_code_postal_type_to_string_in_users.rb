class ChangeCodePostalTypeToStringInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :adresse_code_postal, :string
  end
end
