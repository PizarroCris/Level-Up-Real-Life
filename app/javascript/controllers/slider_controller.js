import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "output"]
  static values = {
    displayMode: { type: String, default: "quantity" }
  }

  connect() {
    if (this.displayModeValue === "costs") {
      this.cost = JSON.parse(this.element.dataset.costJson || "{}")
      this.woodIconUrl = this.element.dataset.woodIconUrl
      this.stoneIconUrl = this.element.dataset.stoneIconUrl
      this.metalIconUrl = this.element.dataset.metalIconUrl
      this.woodDisplay = document.getElementById("profile-wood")
      this.stoneDisplay = document.getElementById("profile-stone")
      this.metalDisplay = document.getElementById("profile-metal")
    }
    this.update()
  }

  update() {
    const quantity = parseInt(this.inputTarget.value, 10);

    if (this.displayModeValue === "costs") {
      const totalWood = (this.cost.wood || 0) * quantity;
      const totalStone = (this.cost.stone || 0) * quantity;
      const totalMetal = (this.cost.metal || 0) * quantity;

      const outputHtml = `
        <span class="me-3">
          Troops: <span class="badge btn-red">${quantity}</span>
        </span>
        <div class="d-flex justify-content-center">
          <span> 
            <span class="cost-item">
              <img src="${this.woodIconUrl}" class="cost-icon"> ${totalWood}
            </span>
            <span class="cost-item">
              <img src="${this.stoneIconUrl}" class="cost-icon"> ${totalStone}
            </span>
            <span class="cost-item">
              <img src="${this.metalIconUrl}" class="cost-icon"> ${totalMetal}
            </span>
          </span>
        </div>
      `;
      this.outputTarget.innerHTML = outputHtml;

      const currentResources = {
        wood: parseInt(this.woodDisplay.textContent, 10),
        stone: parseInt(this.stoneDisplay.textContent, 10),
        metal: parseInt(this.metalDisplay.textContent, 10),
      };
      this.checkResource(this.woodDisplay, currentResources.wood, totalWood);
      this.checkResource(this.stoneDisplay, currentResources.stone, totalStone);
      this.checkResource(this.metalDisplay, currentResources.metal, totalMetal);

    } else {
      this.outputTarget.textContent = quantity;
    }
  }

  checkResource(element, currentAmount, costAmount) {
    if (element && costAmount > currentAmount) {
      element.classList.add("resource-error")
    } else if (element) {
      element.classList.remove("resource-error")
    }
  }
}
