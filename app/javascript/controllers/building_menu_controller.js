import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["popup", "upgradeButton", "infoButton", "upgradeForm", "image", "upgradeCost"]

  toggle(event) {
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

    this.menuTarget.classList.toggle("is-visible")
  }
}
