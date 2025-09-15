class AddTagToGuilds < ActiveRecord::Migration[7.1]
  def change
    add_column :guilds, :tag, :string, null: false

    add_index :guilds, :tag, unique: true
  end
end
