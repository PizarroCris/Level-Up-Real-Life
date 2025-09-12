// app/javascript/controllers/building_menu_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "detailsLink", "upgradeFormContainer"]

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
    // ... (seu código show, sem a linha do classList.add("is-visible"))
    event.stopPropagation()

    const buildingWrapper = event.currentTarget
    const showUrl = buildingWrapper.dataset.buildingShowUrl
    const upgradeUrl = buildingWrapper.dataset.buildingUpgradeUrl
    const canUpgrade = buildingWrapper.dataset.buildingUpgradeCost === "true"

    this.detailsLinkTarget.href = showUrl

    const upgradeForm = this.upgradeFormContainerTarget.querySelector("form")
    if (upgradeForm) {
      upgradeForm.action = upgradeUrl
    }

    this.upgradeFormContainerTarget.style.display = canUpgrade ? 'block' : 'none'

    const containerRect = this.element.getBoundingClientRect();
    const buildingRect = buildingWrapper.getBoundingClientRect();
    const relativeTop = buildingRect.bottom - containerRect.top - 65;
    const relativeLeft = buildingRect.left - containerRect.left + 30;

    this.menuTarget.style.top = `${relativeTop}px`;
    this.menuTarget.style.left = `${relativeLeft}px`;
  }

  toggle(event) {
    this.show(event) // Executa a lógica de posicionamento do menu
    this.menuTarget.classList.toggle("is-visible") // Alterna a visibilidade
  }

  hideOnClick(event) {
    if (event.type === 'click' && this.element.contains(event.target)) {
      return
    }
    this.menuTarget.classList.remove("is-visible")
  }
}
