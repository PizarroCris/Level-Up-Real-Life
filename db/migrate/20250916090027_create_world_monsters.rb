class CreateWorldMonsters < ActiveRecord::Migration[7.1]
  def change
    create_table :world_monsters do |t|
      t.string :name
      t.integer :level
      t.integer :pos_x
      t.integer :pos_y
      t.integer :hp, default: 100
      t.timestamps
    end
  end
end
