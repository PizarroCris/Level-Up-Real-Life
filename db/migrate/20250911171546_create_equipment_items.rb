class CreateEquipmentItems < ActiveRecord::Migration[7.1]
  def change
    create_table :equipment_items do |t|
      t.string :name
      t.string :equipment_type
      t.integer :attack
      t.integer :defense
      t.integer :speed_bonus
      t.integer :price_in_steps

      t.timestamps
    end
  end
end
