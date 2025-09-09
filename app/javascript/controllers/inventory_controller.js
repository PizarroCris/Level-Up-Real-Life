// app/javascript/controllers/inventory_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["inventoryPopup", "menuPopup", "shopPopup"]

  showInventory(event) {
    event.preventDefault()
    this.hideAllPopups()
    this.inventoryPopupTarget.classList.remove("d-none")
    this.inventoryPopupTarget.classList.add("d-block")
  }

  showMenu(event) {
    event.preventDefault()
    this.hideAllPopups()
    this.menuPopupTarget.classList.remove("d-none")
    this.menuPopupTarget.classList.add("d-block")
  }

  showShop(event) {
    event.preventDefault()
    this.hideAllPopups()
    this.shopPopupTarget.classList.remove("d-none")
    this.shopPopupTarget.classList.add("d-block")
  }

  // NOVO MÉTODO: Esconde apenas o pop-up que contém o botão de fechar.
  hidePopup(event) {
    event.preventDefault()
    // Encontra o elemento pai com o data-inventory-target e adiciona a classe para esconder
    const popup = event.currentTarget.closest('[data-inventory-target]');
    if (popup) {
      popup.classList.add("d-none");
      popup.classList.remove("d-block");
    }
  }

  hideAllPopups() {
    this.inventoryPopupTarget.classList.add("d-none")
    this.inventoryPopupTarget.classList.remove("d-block")

    this.menuPopupTarget.classList.add("d-none")
    this.menuPopupTarget.classList.remove("d-block")

    this.shopPopupTarget.classList.add("d-none")
    this.shopPopupTarget.classList.remove("d-block")
  }
}
