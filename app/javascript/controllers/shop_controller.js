// app/javascript/controllers/shop_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["page", "previousButton", "nextButton"]

  connect() {
    this.currentPageIndex = 0
    this.showPage()
  }

  showPage() {
    this.pageTargets.forEach((page, index) => {
      page.classList.toggle("active", index === this.currentPageIndex)
    })
    this.updateButtons()
  }

  nextPage() {
    if (this.currentPageIndex < this.pageTargets.length - 1) {
      this.currentPageIndex++
      this.showPage()
    }
  }

  previousPage() {
    if (this.currentPageIndex > 0) {
      this.currentPageIndex--
      this.showPage()
    }
  }

  updateButtons() {
    this.previousButtonTarget.disabled = this.currentPageIndex === 0
    this.nextButtonTarget.disabled = this.currentPageIndex === this.pageTargets.length - 1
  }
}
