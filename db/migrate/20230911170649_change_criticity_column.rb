class ChangeCriticityColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :tasks, :criticity, 'integer USING CAST(criticity as integer)'
  end
end
