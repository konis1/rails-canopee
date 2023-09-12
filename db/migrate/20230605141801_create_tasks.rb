class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :activity
      t.string :criticity
      t.datetime :due_date
      t.datetime :completion_date
      t.references :garden_plant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
