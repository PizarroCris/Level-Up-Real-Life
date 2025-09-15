class GuildMembershipsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @guild = Guild.find(params[:guild_id])
    @membership = GuildMembership.find(params[:id])

    authorize @membership, :destroy?

    if @membership.destroy
      redirect_to @guild, notice: "#{@membership.profile.username} has been kicked from the guild."
    else
      redirect_to @guild, alert: "Could not kick the member."
    end
  end
end
