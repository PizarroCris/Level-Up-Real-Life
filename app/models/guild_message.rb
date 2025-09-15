class GuildMessage < ApplicationRecord
  belongs_to :profile
  belongs_to :guild

  validates :content, presence: true

  broadcasts_to ->(guild_message) { "guild_chat_#{guild_message.guild.id}" }, inserts_by: :prepend
end
