class AddMapPlotToProfiles < ActiveRecord::Migration[7.1]
  def change
    add_reference :profiles, :map_plot, null: false, foreign_key: true
  end
end
