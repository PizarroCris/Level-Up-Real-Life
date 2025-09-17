import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "wood", "stone", "metal", "steps" ]

  connect() {
    this.initialValues = {
      wood: parseFloat(this.woodTarget.textContent),
      stone: parseFloat(this.stoneTarget.textContent),
      metal: parseFloat(this.metalTarget.textContent),
      steps: parseFloat(this.stepsTarget.textContent)
    };

    this.hourlyRates = {
      wood: parseFloat(this.data.get("woodRate")),
      stone: parseFloat(this.data.get("stoneRate")),
      metal: parseFloat(this.data.get("metalRate"))
    };

    this.startTime = new Date();
    this.interval = setInterval(() => this.updateCounts(), 1000);
  }

  disconnect() {
    clearInterval(this.interval);
  }

  updateCounts() {
    const now = new Date();
    const secondsSinceConnect = (now.getTime() - this.startTime.getTime()) / 1000;

    this.woodTarget.textContent = Math.floor(this.initialValues.wood + (this.hourlyRates.wood / 3600) * secondsSinceConnect);
    this.stoneTarget.textContent = Math.floor(this.initialValues.stone + (this.hourlyRates.stone / 3600) * secondsSinceConnect);
    this.metalTarget.textContent = Math.floor(this.initialValues.metal + (this.hourlyRates.metal / 3600) * secondsSinceConnect);
  }
}
