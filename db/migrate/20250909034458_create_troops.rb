class CreateTroops < ActiveRecord::Migration[7.1]
  def change
    create_table :troops do |t|
      t.string :troop_type
      t.integer :level
      t.integer :attack
      t.integer :defense
      t.integer :speed
      t.references :building, null: false, foreign_key: true

      t.timestamps
    end
  end
end
