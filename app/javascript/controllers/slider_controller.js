import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "output", "troopQuantity", "woodOutput", "stoneOutput", "metalOutput"]
  static values = {
    displayMode: { type: String, default: "quantity" },
    wood: Number,
    stone: Number,
    metal: Number,
    cost: Object
  }

  connect() {
    this.update()
  }

  update() {
    const quantity = parseInt(this.inputTarget.value, 10);

    if (this.displayModeValue === "costs") {
      const totalWood = (this.costValue.wood || 0) * quantity;
      const totalStone = (this.costValue.stone || 0) * quantity;
      const totalMetal = (this.costValue.metal || 0) * quantity;
      
      if (this.hasTroopQuantityTarget) {
        this.troopQuantityTarget.textContent = quantity;
      }
      if (this.hasWoodOutputTarget) {
        this.woodOutputTarget.textContent = totalWood;
      }
      if (this.hasStoneOutputTarget) {
        this.stoneOutputTarget.textContent = totalStone;
      }
      if (this.hasMetalOutputTarget) {
        this.metalOutputTarget.textContent = totalMetal;
      }

      if (this.hasWoodOutputTarget) {
        this.checkResource(this.woodOutputTarget, this.woodValue, totalWood);
      }
      if (this.hasStoneOutputTarget) {
        this.checkResource(this.stoneOutputTarget, this.stoneValue, totalStone);
      }
      if (this.hasMetalOutputTarget) {
        this.checkResource(this.metalOutputTarget, this.metalValue, totalMetal);
      }
    } else {
      this.outputTarget.textContent = quantity;
    }
  }

  checkResource(element, currentAmount, costAmount) {
    if (costAmount > currentAmount) {
      element.classList.add("resource-error")
    } else {
      element.classList.remove("resource-error")
    }
  }
}
