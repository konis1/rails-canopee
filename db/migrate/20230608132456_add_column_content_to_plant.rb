class AddColumnContentToPlant < ActiveRecord::Migration[7.0]
  def change
    add_column :plants, :content, :text
  end
end
