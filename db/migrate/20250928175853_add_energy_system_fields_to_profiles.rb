class AddEnergySystemFieldsToProfiles < ActiveRecord::Migration[7.0]
  def change
    rename_column :profiles, :energy, :current_energy

    add_column :profiles, :max_energy, :integer, default: 100, null: false
    add_column :profiles, :energy_last_updated_at, :datetime
  end
end
