import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="task-checker"
export default class extends Controller {
  static targets = ['all', 'current', 'next']

  connect() {
    console.log(this)
  }

  all() {
    this.allTarget.classList.remove('d-none');
    this.currentTarget.classList.add('d-none');
    this.nextTarget.classList.add('d-none');
  }

  current() {
    this.allTarget.classList.add('d-none');
    this.currentTarget.classList.remove('d-none');
    this.nextTarget.classList.add('d-none');
  }

  next() {
    this.allTarget.classList.add('d-none');
    this.currentTarget.classList.add('d-none');
    this.nextTarget.classList.remove('d-none');
  }
}
