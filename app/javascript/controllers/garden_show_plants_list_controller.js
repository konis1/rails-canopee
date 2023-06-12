import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="garden-show-plants-list"
export default class extends Controller {
  static values = {
    cardPosition: Number
  }

  connect() {
    console.log(this.element)
    let position = 320
    for (let i = 1; i < this.element.children.length; i++) {
      this.element.children.item(i).style = `position: relative; bottom: ${position}px`
      position += 320
    }
    this.element.style = `height: ${450 + 130 * (this.element.children.length-1)}px; overflow: hidden`
  }
}
