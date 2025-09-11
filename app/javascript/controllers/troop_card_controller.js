import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["image", "button"]
  static values = { level: Number, barrackLevel: Number }

  connect() {
    this.checkIfDisabled()
  }

  checkIfDisabled() {
    if (this.levelValue > this.barrackLevelValue) {
      this.element.classList.add("disabled-troop")
      this.buttonTarget.disabled = true
    }
  }
}
