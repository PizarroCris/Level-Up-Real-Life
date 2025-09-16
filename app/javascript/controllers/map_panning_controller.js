import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["world"]
  
  static values = {
    myCastleX: Number,
    myCastleY: Number
  }

  connect() {
    this.isDragging = false
    this.startX = 0
    this.startY = 0
    this.initialLeft = 0
    this.initialTop = 0
  }

  startDrag(event) {
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
