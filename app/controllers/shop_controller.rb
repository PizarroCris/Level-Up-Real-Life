class ShopController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_profile!

  def show
    @equipments = EquipmentItem.all
    @profile = current_user.profile
    authorize :shop
  end
end
