class GuildsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_profile!
  before_action :set_guild, only: %i[show edit update destroy]

  def index
     @guilds = policy_scope(Guild)
  end

  def show
    authorize @guild
  end

  def new
    @guild = Guild.new
    authorize @guild
  end

  def create
    @guild = Guild.new(guild_params)
    @guild.leader = current_user.profile
    authorize @guild

    if @guild.save
      redirect_to @guild, notice: "Guild created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_guild
    @guild = Guild.find(params[:id])
  end

  def guild_params
    params.require(:guild).permit(:name, :description, :tag)
  end
end
