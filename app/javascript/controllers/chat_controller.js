import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["body"]

  connect() {
    this.element.classList.add("is-collapsed")
  }

  toggle() {
    this.element.classList.toggle("is-collapsed")
  }
}
