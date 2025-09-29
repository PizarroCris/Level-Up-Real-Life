import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    current: Number,
    max: Number,
    secondsUntilNext: Number,
    rateInSeconds: Number
  }

  static targets = ["bar", "display"]

  connect() {
    this.currentEnergy = this.currentValue
    this.countdown = this.secondsUntilNextValue

    if (this.currentEnergy < this.maxValue) {
      this.startTimer()
    }
    this.updateDisplay()
  }

  startTimer() {
    this.timerInterval = setInterval(() => {
      this.tick()
    }, 1000)
  }

  tick() {
    this.countdown--

    if (this.countdown <= 0) {
      this.currentEnergy++
      this.countdown = this.rateInSecondsValue
    }

    if (this.currentEnergy >= this.maxValue) {
      clearInterval(this.timerInterval)
    }
  }

  updateDisplay() {
    this.displayTarget.textContent = `${this.currentEnergy} / ${this.maxValue}`
    
    const imageLevel = Math.floor(this.currentEnergy / 10)

    const imagePath = `/assets/energy_bars/energy_${imageLevel}.png`

    this.barTarget.src = imagePath
  }
}
