class AddPlotToBuildings < ActiveRecord::Migration[7.1]
  def change
    add_reference :buildings, :plot, null: false, foreign_key: true
  end
end
