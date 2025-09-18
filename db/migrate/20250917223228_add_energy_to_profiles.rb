class AddEnergyToProfiles < ActiveRecord::Migration[7.1]
  def change
    add_column :profiles, :energy, :integer, null: false, default: 100
  end
end
