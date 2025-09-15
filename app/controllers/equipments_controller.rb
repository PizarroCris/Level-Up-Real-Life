class EquipmentsController < ApplicationController

  def create

    item = EquipmentItem.find(params[:equipment_item_id])
    profile = current_user.profile
    equipment = Equipment.new(profile: profile, equipment_item: item)

    authorize equipment
    equipment.save!
    redirect_to root_path
  end
end
