import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="collapse"
export default class extends Controller {
  static targets = ["toggableElement","link"]
  static values = {opened: Boolean}

  connect() {
  }
  fire() {
    event.preventDefault();
    this.toggableElementTarget.classList.toggle("d-none");
    this.openedValue = !this.openedValue;
    if (this.openedValue) {
      this.linkTarget.innerText="Voir moins";
    }
    else {
      this.linkTarget.innerText="Voir plus";
    }
  }
}
