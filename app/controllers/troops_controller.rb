class TroopsController < ApplicationController
  before_action :set_building

  def index
    @profile = current_user.profile
    @barrack_level = @building.level
    @troop_counts = policy_scope(@building.troops).group(:troop_type, :level).count.transform_keys { |k| "#{k[0]}-#{k[1]}" }
    @troops_by_level = {}
    Troop::TROOP_STATS.each do |troop_type, levels|
      levels.each do |level, stats|
        @troops_by_level[level] ||= []
        @troops_by_level[level] << { type: troop_type, stats: stats }
      end
    end
  end

  def create
    quantity = troop_params[:quantity].to_i
    profile = current_user.profile
    @troop = @building.troops.new(troop_params.except(:quantity))
    authorize @troop

    if quantity.zero?
      redirect_to building_troops_path(@building), alert: "Please select a quantity."
      return
    end

    stats = Troop::TROOP_STATS[troop_params[:troop_type].to_sym][troop_params[:level].to_i]
    cost_per_troop = stats[:cost]

    total_cost = {
      wood: cost_per_troop[:wood] * quantity,
      stone: cost_per_troop[:stone] * quantity,
      metal: cost_per_troop[:metal] * quantity
    }

    unless profile.can_afford?(total_cost)
      redirect_to building_troops_path(@building), alert: "Not enough resources!"
      return
    end

    ActiveRecord::Base.transaction do
      profile.deduct_resources!(total_cost)
      quantity.times do
        @building.troops.create!(
          troop_type: troop_params[:troop_type],
          level: troop_params[:level],
          attack: stats[:attack],
          defense: stats[:defense]
        )
      end
    end
    redirect_to building_troops_path(@building), notice: "Training #{quantity} #{troop_params[:troop_type].to_s.pluralize}..."
  
  rescue ActiveRecord::RecordInvalid => e
    redirect_to building_troops_path(@building), alert: "Could not train troops: #{e.message}"
  end

  private

  def set_building
    @building = Building.find(params[:building_id])
  end

  def troop_params
    params.require(:troop).permit(:troop_type, :level, :quantity)
  end
end
