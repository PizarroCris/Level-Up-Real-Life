import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["world", "popup", "popupTitle", "popupButtons"]
  static values = { myCastleX: Number, myCastleY: Number }

  connect() {
    this.isDragging = false
    this.boundCloseOnClickOutside = this.closeOnClickOutside.bind(this)
    document.addEventListener("click", this.boundCloseOnClickOutside)
  }

  disconnect() {
    document.removeEventListener("click", this.boundCloseOnClickOutside)
  }

  showPopup(event) {
    event.preventDefault()
    event.stopPropagation()

    const itemElement = event.currentTarget
    const profileName = itemElement.dataset.profileName
    const interactionOptions = JSON.parse(itemElement.dataset.interactionOptions)
    
    this.popupTitleTarget.textContent = profileName
    this.popupButtonsTarget.innerHTML = ""

    interactionOptions.forEach(option => {
      const link = document.createElement('a')
      link.href = option.path
      link.className = `btn btn-sm ${option.class} mt-2 d-block`
      link.textContent = option.text
      this.popupButtonsTarget.appendChild(link)
    })
    
    this.popupTarget.style.display = 'block'
  }

  closePopup() {
    this.popupTarget.style.display = 'none'
  }
  
  closeOnClickOutside(event) {
    if (this.popupTarget.style.display === 'block' && !this.popupTarget.contains(event.target)) {
      if (!event.target.closest('.castle-plot')) {
        this.closePopup()
      }
    }
  }

  startDrag(event) {
    if (this.popupTarget.style.display === 'block') { return }
    if (event.target.closest('a, button')) { return }

    event.preventDefault()
    this.isDragging = true
    this.element.style.cursor = 'grabbing'
    this.startX = event.pageX - this.element.offsetLeft
    this.startY = event.pageY - this.element.offsetTop
    this.initialLeft = this.worldTarget.offsetLeft
    this.initialTop = this.worldTarget.offsetTop
  }

  drag(event) {
    if (!this.isDragging) return
    event.preventDefault()
    
    const x = event.pageX - this.element.offsetLeft, y = event.pageY - this.element.offsetTop;
    const walkX = x - this.startX, walkY = y - this.startY;
    const newLeft = this.initialLeft + walkX, newTop = this.initialTop + walkY;
    const vpW = this.element.offsetWidth, mapW = this.worldTarget.offsetWidth;
    const minL = vpW - mapW, maxL = 0;
    const vpH = this.element.offsetHeight, mapH = this.worldTarget.offsetHeight;
    const minT = vpH - mapH, maxT = 0;
    const cX = Math.max(minL, Math.min(newLeft, maxL)), cY = Math.max(minT, Math.min(newTop, maxT));
    this.worldTarget.style.left = `${cX}px`;
    this.worldTarget.style.top = `${cY}px`;
  }

  stopDrag() {
    this.isDragging = false
    this.element.style.cursor = 'grab'
  }

  centerOnMyCastle() {
    if (!this.hasMyCastleXValue||!this.hasMyCastleYValue) return;
    const vpW = this.element.offsetWidth, vpH = this.element.offsetHeight;
    let tX = (vpW/2)-this.myCastleXValue, tY = (vpH/2)-this.myCastleYValue;
    const mapW = this.worldTarget.offsetWidth, minL = vpW - mapW, maxL = 0;
    const mapH = this.worldTarget.offsetHeight, minT = vpH - mapH, maxT = 0;
    tX = Math.max(minL, Math.min(tX, maxL));
    tY = Math.max(minT, Math.min(tY, maxT));
    this.worldTarget.style.left = `${tX}px`;
    this.worldTarget.style.top = `${tY}px`;
  }
}
