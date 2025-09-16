class CreateMapPlots < ActiveRecord::Migration[7.1]
  def change
    create_table :map_plots do |t|
      t.integer :pos_x
      t.integer :pos_y

      t.timestamps
    end
  end
end
