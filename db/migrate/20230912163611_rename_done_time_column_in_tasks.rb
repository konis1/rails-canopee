class RenameDoneTimeColumnInTasks < ActiveRecord::Migration[7.0]
  def change
    rename_column :tasks, :completion_date, :completion_date
  end
end
