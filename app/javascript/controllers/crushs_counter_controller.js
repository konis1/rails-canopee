import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="crushs-counter"
export default class extends Controller {
  static targets = ['counter', 'garden']

  connect() {
    // this.counterTarget.innerText = `${this.gardenTargets.length}`
  }
}
