class MapsController < ApplicationController
  def index
    @castles = policy_scope(Building).where(building_type: 'castle').includes(profile: :map_plot)
    @monsters = policy_scope(WorldMonster)
    @equipments = EquipmentItem.all
    @available_plots = policy_scope(MapPlot).where.missing(:profile)
  end
end
