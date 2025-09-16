class ChangePlotCoordinatesToPixels < ActiveRecord::Migration[7.1]
  def change
    remove_column :plots, :top_percent, :float
    remove_column :plots, :left_percent, :float
    add_column :plots, :pos_x, :integer
    add_column :plots, :pos_y, :integer
  end
end
