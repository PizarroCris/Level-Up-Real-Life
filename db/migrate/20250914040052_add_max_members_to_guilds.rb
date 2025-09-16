class AddMaxMembersToGuilds < ActiveRecord::Migration[7.1]
  def change
    add_column :guilds, :max_members, :integer
  end
end
