class GuildsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_profile!
  before_action :set_guild, only: %i[show edit update join destroy]

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

  def join    
    authorize @guild, :join?
    
    if @guild.full?
      redirect_to @guild, alert: "This guild has reached its member limit."
    else
      current_user.update(guild: @guild)
      redirect_to @guild, notice: "You've successfully joined the guild!"
    end
  rescue Pundit::NotAuthorizedError
    redirect_to guilds_path, alert: "You already belong to a guild and cannot join another."
  end

  private

  def set_guild
    @guild = Guild.find(params[:id])
  end

  def guild_params
    params.require(:guild).permit(:name, :description, :tag)
  end
end
