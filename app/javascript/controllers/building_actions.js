import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "title", "buttons", "details"]

  connect() {
    this.boundCloseOnClickOutside = this.closeOnClickOutside.bind(this)
    document.addEventListener("click", this.boundCloseOnClickOutside)
  }

  disconnect() {
    document.removeEventListener("click", this.boundCloseOnClickOutside)
  }

  showPopup(event) {
    event.stopPropagation()
    const wrapper = event.currentTarget
    const info = JSON.parse(wrapper.dataset.interactionOptions)

    this.titleTarget.textContent = info.title
    this.detailsTarget.textContent = info.details
    this.buttonsTarget.innerHTML = ""

    info.buttons.forEach(buttonInfo => {
      if (buttonInfo.method) {
        const form = document.createElement('form')
        form.action = buttonInfo.path
        form.method = 'post'
        form.dataset.turboMethod = buttonInfo.method
        const csrfToken = document.querySelector('meta[name="csrf-token"]').content
        const csrfInput = document.createElement('input')
        csrfInput.type = 'hidden'
        csrfInput.name = 'authenticity_token'
        csrfInput.value = csrfToken
        form.appendChild(csrfInput)
        if (buttonInfo.method !== 'post') {
          const methodInput = document.createElement('input')
          methodInput.type = 'hidden'
          methodInput.name = '_method'
          methodInput.value = buttonInfo.method
          form.appendChild(methodInput)
        }
        const button = document.createElement('button')
        button.type = 'submit'
        button.className = `btn ${buttonInfo.class} btn-sm d-block w-100 mt-2`
        button.textContent = buttonInfo.text
        if (buttonInfo.disabled) {
          button.disabled = true
          button.textContent = "Max Level"
        }
        form.appendChild(button)
        this.buttonsTarget.appendChild(form)
      } else {
        const link = document.createElement('a')
        link.href = buttonInfo.path
        link.className = `btn ${buttonInfo.class} btn-sm d-block w-100 mt-2`
        link.textContent = buttonInfo.text
        this.buttonsTarget.appendChild(link)
      }
    })
    
    this.menuTarget.style.left = `${wrapper.parentElement.offsetLeft + 60}px`
    this.menuTarget.style.top = `${wrapper.parentElement.offsetTop}px`
    this.menuTarget.style.display = "block"
  }

  hidePopup() {
    if (this.hasMenuTarget) {
      this.menuTarget.style.display = "none"
    }
  }

  closeOnClickOutside(event) {
    if (this.hasMenuTarget && this.menuTarget.style.display === 'block') {
      if (!this.menuTarget.contains(event.target) && !event.target.closest('.building-wrapper')) {
        this.hidePopup()
      }
    }
  }
}
