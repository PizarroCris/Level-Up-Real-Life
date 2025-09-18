import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    this.element.style.opacity = 0
    setTimeout(() => { this.element.style.opacity = 1 }, 10)
  }

  close() {
    this.element.remove()

  static targets = ["menu"]

  toggle(event) {
    event.stopPropagation()
    const open = this.menuTarget.classList.toggle("is-visible")

    // Update aria-expanded on wrapper
    const wrapper = this.element.querySelector(".building-wrapper")
    if (wrapper) wrapper.setAttribute("aria-expanded", open ? "true" : "false")
  }

  hideOnDocumentClick = (e) => {
    if (!this.element.contains(e.target)) {
      this.menuTarget.classList.remove("is-visible")
      const wrapper = this.element.querySelector(".building-wrapper")
      if (wrapper) wrapper.setAttribute("aria-expanded", "false")
    }
  }

  connect() {
    document.addEventListener("click", this.hideOnDocumentClick)
  }

  disconnect() {
    document.removeEventListener("click", this.hideOnDocumentClick)
  }
}
