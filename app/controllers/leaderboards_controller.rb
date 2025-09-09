class LeaderboardsController < ApplicationController
  skip_after_action :verify_authorized, only: :index
  skip_after_action :verify_policy_scoped, only: :index

  def index
    @profiles = Profile.order(experience: :desc)
  end
end
