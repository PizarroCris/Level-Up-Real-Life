class PagesController < ApplicationController
  before_action :set_team, only: [:contact, :about]

  def home
    if user_signed_in?
      redirect_to user_base_path
    end
  end

  def contact
  end

  def submit_contact
    ContactMailer.new_message(params[:first_name], params[:last_name], params[:email], params[:message]).deliver_now
    redirect_to contact_path
  end

  def about
  end

  def inventory
    @equipments = current_user.profile.equipments
  end

  private

  def set_team
    @team = [
      { name: "Caio Figueiredo",
        github: "https://github.com/CAiAuM",
        linkedin: "https://www.linkedin.com/in/caio-monteiro-de-figueiredo-48847a69/",
        flag: "🇧🇷",
        email: "caio-email-placeholder",
        image: "team/caio.jpg"},

      { name: "Cristiano Pizarro",
        github: "https://github.com/PizarroCris",
        linkedin: "https://www.linkedin.com/in/cristiano-pizarro/",
        flag: "🇵🇹",
        email: "cristiano-email-placeholder",
        image: "team/cristiano.jpg"},

      { name:  "Yan Buxes",
        github: "https://github.com/ynbxs",
        linkedin: "https://www.linkedin.com/in/yan-buxes-a4337a35b/",
        flag: "🇧🇪",
        email: "yan-email-placeholder",
        image: "team/yan.jpg" }
    ]
  end
end
