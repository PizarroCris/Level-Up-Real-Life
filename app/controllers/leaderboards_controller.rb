class LeaderboardsController < ApplicationController
  skip_after_action :verify_authorized, only: :index
  skip_after_action :verify_policy_scoped, only: :index

  def index
    @profiles = Profile
      .left_joins(:won_battles)                                  # join battles where profile is the winner
      .select('profiles.*, COUNT(battles.id) AS wins_count')     # virtual column
      .group('profiles.id')
      .order('wins_count DESC, profiles.created_at ASC')
      .limit(100)
  end
end
