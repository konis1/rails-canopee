import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="garden-form"
export default class extends Controller {
  static targets = ['input', 'button']

  connect() {
    console.log(this.buttonTarget);
    this.currentStep = 1
    this.stepsCount = this.inputTargets.length
  }

  goToNextQuestion(event) {
    // Cacher l'input qui n'a pas la classe 'd-none' (ou l'input courant)
    // Retirer la classe 'd-none' de l'input courant
    // this.InputTarget.classList.add();
    // this.InputTarget.classList.remove();
    this.currentStep++
    console.log(this.currentStep);
    console.log(this.#getNextInput())

    if (this.#getPreviousInput()) this.#getPreviousInput().classList.add('d-none');
    if (this.#getNextInput()) this.#getNextInput().classList.remove('d-none');
    if (this.currentStep == 4) {
      this.buttonTarget.classList.remove('d-none');
      event.currentTarget.classList.add('d-none');
    }

  }

  #getCurrentInput() {}
  #getPreviousInput() {
    return this.inputTargets[this.currentStep - 2]
  }

  #getNextInput() {
    return this.inputTargets[this.currentStep - 1]
  }
}