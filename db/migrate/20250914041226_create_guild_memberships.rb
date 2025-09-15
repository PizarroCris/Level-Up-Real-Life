class CreateGuildMemberships < ActiveRecord::Migration[7.1]
  def change
    create_table :guild_memberships do |t|
      t.references :guild, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true
      t.integer :role

      t.timestamps
    end
  end
end
