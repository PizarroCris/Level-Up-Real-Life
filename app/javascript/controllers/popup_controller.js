import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  connect() {
    this.element.style.opacity = 0;
    setTimeout(() => { this.element.style.opacity = 1 }, 10);
  }

  close() {
    this.element.remove()
  }

  static targets = ["menu"]

  toggle(event) {
    event.stopPropagation()
    const open = this.menuTarget.classList.toggle("is-visible")

    const wrapper = this.element.querySelector(".building-wrapper")
    if (wrapper) wrapper.setAttribute("aria-expanded", open ? "true" : "false")
  }
  stop(event) {
    event.stopPropagation();
  }
}
