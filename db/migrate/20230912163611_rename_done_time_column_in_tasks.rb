class RenameDoneTimeColumnInTasks < ActiveRecord::Migration[7.0]
  def change
    rename_column :tasks, :done_time, :completion_date
  end
end
