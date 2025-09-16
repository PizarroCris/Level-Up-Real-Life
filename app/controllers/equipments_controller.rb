class EquipmentsController < ApplicationController
  def create
    item     = EquipmentItem.find(params[:equipment_item_id])
    profile  = current_user.profile
    equipment = Equipment.new(profile: profile, equipment_item: item)

    authorize equipment

    if profile.can_buy?(item)
      profile.spend_steps!(item.price_in_steps) 
      equipment.save!
      redirect_to root_path, notice: "Purchased #{item.name}!"
    else
      redirect_to root_path, alert: "Not enough steps."
    end
  end
end
