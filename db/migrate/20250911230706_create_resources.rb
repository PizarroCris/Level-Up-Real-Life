class CreateResources < ActiveRecord::Migration[7.1]
  def change
    create_table :resources do |t|
      t.integer :kind, null: false
      t.integer :level, null: false, default: 1
      t.references :building, null: false, foreign_key: true

      t.timestamps
    end
    add_index :resources, [:building_id, :kind], unique: true
  end
end
