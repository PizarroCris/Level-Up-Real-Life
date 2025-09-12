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

  private

  def set_team
    @team = [
      { name: "Brenda Silva",
        github: "https://github.com/brendaamsilva",
        linkedin: "https://www.linkedin.com/in/brendaamsilva",
        email: "brenda.amsilva(at)gmail.com",
        image: "team/brenda.jpg"},

      { name: "Caio Figueiredo",
        github: "https://github.com/CAiAuM",
        linkedin: "https://www.linkedin.com/in/caio-monteiro-de-figueiredo-48847a69/",
        email: "caio-email-placeholder",
        image: "team/caio.jpg"},

      { name: "Cristiano Pizarro",
        github: "https://github.com/PizarroCris",
        linkedin: "https://www.linkedin.com/in/cristiano-pizarro/",
        email: "cris-email-placeholder",
        image: "team/cristiano.jpg"},

      { name:  "Yan Buxes",
        github: "https://github.com/ynbxs",
        email: "yan-email-placeholder",
        linkedin: "https://www.linkedin.com/in/yan-buxes-a4337a35b/",
        image: "team/yan.jpg" }
    ]
  end
end
