import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.style.opacity = 0
    setTimeout(() => { this.element.style.opacity = 1 }, 10)
  }

  close() {
    this.element.remove()
  }
}
