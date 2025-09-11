class CreateEquipment < ActiveRecord::Migration[7.1]
  def change
    create_table :equipment do |t|
      t.string :name
      t.references :profile, null: false, foreign_key: true
      t.integer :attack
      t.integer :defense
      t.integer :required_steps
      t.string :equipment_type

      t.timestamps
    end
  end
end
