class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :activity
      t.string :criticity
      t.datetime :due_date
      t.datetime :done_time
      t.references :garden_plant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
