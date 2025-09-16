class CreateGuilds < ActiveRecord::Migration[7.1]
  def change
    create_table :guilds do |t|
      t.string :name, null: false
      t.text :description
      t.references :leader, null: false, foreign_key: { to_table: :profiles }

      t.timestamps
    end
  end
end
