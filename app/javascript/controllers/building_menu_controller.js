import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "detailsLink", "upgradeFormContainer", "collectButton"]

  connect() {
    this.boundHideOnClick = this.hideOnClick.bind(this)
    document.addEventListener("click", this.boundHideOnClick)
    window.addEventListener("resize", this.boundHideOnClick)
  }

  disconnect() {
    document.removeEventListener("click", this.boundHideOnClick)
    window.removeEventListener("resize", this.boundHideOnClick)
  }

  show(event) {
    event.stopPropagation()

    const buildingWrapper = event.currentTarget
    const showUrl = buildingWrapper.dataset.buildingShowUrl
    const upgradeUrl = buildingWrapper.dataset.buildingUpgradeUrl
    const collectUrl = buildingWrapper.dataset.buildingCollectUrl
    const canUpgrade = buildingWrapper.dataset.buildingUpgradeCost === "true"

    this.detailsLinkTarget.href = showUrl

    const upgradeForm = this.upgradeFormContainerTarget.querySelector("form")
    if (upgradeForm) {
      upgradeForm.action = upgradeUrl
    }

    this.upgradeFormContainerTarget.style.display = canUpgrade ? 'block' : 'none'

    // Posicionamento do menu
    const containerRect = this.element.getBoundingClientRect();
    const buildingRect = buildingWrapper.getBoundingClientRect();
    const relativeTop = buildingRect.bottom - containerRect.top - 65;
    const relativeLeft = buildingRect.left - containerRect.left + 30;

    this.menuTarget.style.top = `${relativeTop}px`;
    this.menuTarget.style.left = `${relativeLeft}px`;
  }

  toggle(event) {
    this.show(event)
    this.menuTarget.classList.toggle("is-visible")
  }

  hideOnClick(event) {
    if (event.type === 'click' && this.element.contains(event.target)) {
      return
    }
    this.menuTarget.classList.remove("is-visible")
  }
}
