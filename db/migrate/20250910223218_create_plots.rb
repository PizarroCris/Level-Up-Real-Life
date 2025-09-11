class CreatePlots < ActiveRecord::Migration[7.1]
  def change
    create_table :plots do |t|
      t.string :name
      t.decimal :top_percent
      t.decimal :left_percent

      t.timestamps
    end
  end
end
