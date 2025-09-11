# app/controllers/troops_controller.rb
class TroopsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_profile!
  before_action :set_building, only: [:index, :new, :create]

  skip_after_action :verify_authorized, only: [:index, :new, :create]
  skip_after_action :verify_policy_scoped, only: [:index]

  def index
    # 1. Busca as tropas para exibição, com ordenação
    @troops = @building.troops.order(created_at: :desc)

    # para validar o nivel do quartel
    # para permitir somente criação de tropa no msm nv do quartel
    @barrack_level = @building.level

    # 2. Realiza a contagem em uma nova consulta, sem a ordenação
    @troop_counts = @building.troops.group(:troop_type, :level).count.transform_keys do |(type, level)|
    "#{type}-#{level}"
  end
  end

  def new
    @troop = @building.troops.new
  end

def create
  @troop = @building.troops.new(troop_params)
  if @troop.save
    redirect_to building_troops_path(@building)
  else
    render :new, status: :unprocessable_entity
  end
end

  private

  def set_building
    @building = Building.find(params[:building_id])
  end

  def ensure_profile!
    return if current_user.profile.present?
    current_user.create_profile!(username: current_user.email.split("@").first)
  end

  def troop_params
    params.require(:troop).permit(:troop_type, :level)
  end
end
