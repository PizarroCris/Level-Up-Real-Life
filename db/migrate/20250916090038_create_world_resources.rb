class CreateWorldResources < ActiveRecord::Migration[7.1]
  def change
    create_table :world_resources do |t|
      t.string :name
      t.string :resource_type
      t.integer :pos_x
      t.integer :pos_y

      t.timestamps
    end
  end
end
