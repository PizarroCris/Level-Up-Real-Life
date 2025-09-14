class GuildMembership < ApplicationRecord
  belongs_to :guild
  belongs_to :profile

  enum role: { member: 0, officer: 1, leader: 2 }
end
