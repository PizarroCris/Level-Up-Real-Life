class MapController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_profile!

  def show
    authorize Profile
    @profiles = policy_scope(Profile)
  end

  private

  def ensure_profile!
    return if current_user.profile.present?
    current_user.create_profile!(username: current_user.email.split("@").first)
  end
end
