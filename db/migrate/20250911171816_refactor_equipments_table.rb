class RefactorEquipmentsTable < ActiveRecord::Migration[7.1]
  def change
    add_reference :equipment, :equipment_item, null: false, foreign_key: true

    remove_column :equipment, :attack, :integer
    remove_column :equipment, :defense, :integer
    remove_column :equipment, :required_steps, :integer
    remove_column :equipment, :name, :string
    remove_column :equipment, :equipment_type, :string
  end
end
