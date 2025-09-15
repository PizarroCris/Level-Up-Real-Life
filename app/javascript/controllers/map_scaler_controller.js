import { Controller } from "@hotwired/stimulus"
import debounce from "lodash.debounce"

export default class extends Controller {
  static targets = ["content"]

  static values = {
    originalWidth: { type: Number, default: 1280 },
    originalHeight: { type: Number, default: 720 }
  }

  connect() {
    this.debouncedResize = debounce(this.resize.bind(this), 10)
    window.addEventListener("resize", this.debouncedResize)
    
    this.resize()
  }

  disconnect() {
    window.removeEventListener("resize", this.debouncedResize)
  }

  resize() {
    if (!this.hasContentTarget) { return }

    const currentContainerWidth = this.element.offsetWidth
    const scaleRatio = currentContainerWidth / this.originalWidthValue
    
    this.contentTarget.style.transform = `scale(${scaleRatio})`
  }
}
