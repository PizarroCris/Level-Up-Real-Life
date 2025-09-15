class GuildMessagesController < ApplicationController
  before_action :set_guild

  def create
    @guild_message = GuildMessage.new(message_params)
    @guild_message.profile = current_user.profile
    @guild_message.guild = @guild
    authorize @guild_message

    respond_to do |format|
      if @guild_message.save
        format.turbo_stream
      else
        render json: { errors: @guild_message.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  private

  def set_guild
    @guild = Guild.find(params[:guild_id])
  end

  def message_params
    params.require(:guild_message).permit(:content)
  end
end
