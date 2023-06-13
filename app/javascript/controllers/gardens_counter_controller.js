import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gardens-counter"
export default class extends Controller {
  static targets = ['counter', 'crush']

  connect() {
    this.counterTarget.innerText = this.gardenTargets.length
  }
}
