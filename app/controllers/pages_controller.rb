class PagesController < ApplicationController
  def home
  end

  def contact
    @user = current_user
  end

  def about
     @team = [
      { name: "Brenda Silva",
        github: "https://github.com/brendaamsilva",
        linkedin: "https://www.linkedin.com/in/brendaamsilva",
        image: "team/brenda.jpg"},

      { name: "Caio Figueiredo",
        github: "https://github.com/CAiAuM",
        linkedin: "https://www.linkedin.com/in/caio-monteiro-de-figueiredo-48847a69/",
        image: "team/caio.jpg"},

      { name: "Cristiano Pizarro",
        github: "https://github.com/PizarroCris",
        linkedin: "https://www.linkedin.com/in/cristiano-pizarro/",
        image: "team/cristiano.jpg"},

      { name:  "Yan Buxes",
        github: "https://github.com/ynbxs",
        linkedin: "https://www.linkedin.com/in/yan-buxes-a4337a35b/",
        image: "team/yan.jpg" }
    ]
  end
end
