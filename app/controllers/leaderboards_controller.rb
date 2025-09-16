class LeaderboardsController < ApplicationController
  skip_after_action :verify_authorized, only: %i[index guilds]
  skip_after_action :verify_policy_scoped, only: %i[index guilds]

  def index
    @profiles = Profile
      .left_joins(:won_battles)
      .select('profiles.*, COUNT(battles.id) AS wins_count')
      .group('profiles.id')
      .order('wins_count DESC, profiles.created_at ASC')
      .limit(100)
  end

  def guilds
    @guilds = Guild
      .left_joins(profiles: :won_battles)
      .select('guilds.*, COUNT(battles.id) AS wins_count, COUNT(DISTINCT guild_memberships.id) AS members_count')
      .group('guilds.id')
      .order('wins_count DESC, members_count DESC, guilds.created_at ASC')
      .limit(100)
  end
end
