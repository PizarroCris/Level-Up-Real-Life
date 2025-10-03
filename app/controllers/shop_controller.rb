class ShopController < ApplicationController
  before_action :authenticate_user!
  skip_after_action :verify_authorized, only: [:create_checkout_session]

  def show
    @equipments = EquipmentItem.all
    @profile = current_user.profile
    authorize :shop
  end

  def create_checkout_session
    session = Stripe::Checkout::Session.create({
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: {
            name: '1000 Passos',
          },
          unit_amount: 500,
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: root_url,
      cancel_url: root_url,
      client_reference_id: current_user.id
    })
    redirect_to session.url, allow_other_host: true
  end

  private

  def ensure_profile!
    return if current_user.profile.present?
    current_user.create_profile!(username: current_user.email.split("@").first)
  end
end
