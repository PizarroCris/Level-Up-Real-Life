import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["world", "popup", "popupTitle", "popupDetails", "popupButtons"]
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
    event.preventDefault();
    event.stopPropagation();

    const itemElement = event.currentTarget;
    const popupInfo = JSON.parse(itemElement.dataset.interactionOptions);
    
    this.popupTitleTarget.textContent = popupInfo.title;
    this.popupDetailsTarget.textContent = popupInfo.details;
    this.popupButtonsTarget.innerHTML = "";

    popupInfo.buttons.forEach(option => {
      if (option.method === 'post') {
        const form = document.createElement('form');
        form.action = option.path;
        form.method = 'post';
        form.dataset.turbo = "true";

        const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

        const csrfInput = document.createElement('input');
        csrfInput.type = 'hidden';
        csrfInput.name = 'authenticity_token';
        csrfInput.value = csrfToken;

        form.appendChild(csrfInput);

        if (option.defender_id) {
          const defenderInput = document.createElement('input');
          defenderInput.type = 'hidden';
          defenderInput.name = 'battle[defender_id]';
          defenderInput.value = option.defender_id;
          form.appendChild(defenderInput);
        }
        
        const button = document.createElement('button');
        button.type = 'submit';
        button.className = `btn btn-sm ${option.class} mt-2 d-block w-100`;
        button.textContent = option.text;
        
        form.appendChild(button);
        this.popupButtonsTarget.appendChild(form);

      } else {
        const link = document.createElement('a');
        link.href = option.path;
        link.className = `btn btn-sm ${option.class} mt-2 d-block`;
        link.textContent = option.text;
        this.popupButtonsTarget.appendChild(link);
      }
    });
    
    this.popupTarget.style.display = 'block';
  }

  closePopup() {
    if (this.hasPopupTarget) {
      this.popupTarget.style.display = 'none'
    }
  }

  closeOnClickOutside(event) {
    if (this.hasPopupTarget && this.popupTarget.style.display === 'block' && !this.popupTarget.contains(event.target)) {
      if (!event.target.closest('.map-item')) {
        this.closePopup()
      }
    }
  }

  startDrag(event) {
    if (this.popupTarget.style.display === 'block' || event.target.closest('a, button')) { return }
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

    const x = event.pageX - this.element.offsetLeft
    const y = event.pageY - this.element.offsetTop
    const walkX = x - this.startX
    const walkY = y - this.startY

    const newLeft = this.initialLeft + walkX
    const newTop = this.initialTop + walkY
    
    const viewportWidth = this.element.offsetWidth
    const mapWidth = this.worldTarget.offsetWidth
    const minLeft = viewportWidth - mapWidth
    const maxLeft = 0
    
    const viewportHeight = this.element.offsetHeight
    const mapHeight = this.worldTarget.offsetHeight
    const minTop = viewportHeight - mapHeight
    const maxTop = 0
    
    const clampedX = Math.max(minLeft, Math.min(newLeft, maxLeft))
    const clampedY = Math.max(minTop, Math.min(newTop, maxTop))

    this.worldTarget.style.left = `${clampedX}px`
    this.worldTarget.style.top = `${clampedY}px`
  }

  stopDrag() {
    this.isDragging = false
    this.element.style.cursor = 'grab'
  }

  centerOnMyCastle() {
    if (!this.hasMyCastleXValue || !this.hasMyCastleYValue) return

    const viewportWidth = this.element.offsetWidth
    const viewportHeight = this.element.offsetHeight

    let targetX = (viewportWidth / 2) - this.myCastleXValue
    let targetY = (viewportHeight / 2) - this.myCastleYValue

    const mapWidth = this.worldTarget.offsetWidth
    const minLeft = viewportWidth - mapWidth
    const maxLeft = 0
    
    const mapHeight = this.worldTarget.offsetHeight
    const minTop = viewportHeight - mapHeight
    const maxTop = 0

    targetX = Math.max(minLeft, Math.min(targetX, maxLeft))
    targetY = Math.max(minTop, Math.min(targetY, maxTop))
    
    this.worldTarget.style.left = `${targetX}px`
    this.worldTarget.style.top = `${targetY}px`
  }
}
