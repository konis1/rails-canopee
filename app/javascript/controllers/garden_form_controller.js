import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="garden-form"
export default class extends Controller {
  static targets = ['input', 'button', 'stepCount']

  connect() {
    console.log(this.buttonTarget);
    this.currentStep = 1
    this.stepsCount = this.inputTargets.length
    this.#setStepCount()
  }

  goToNextQuestion(event) {
    // Cacher l'input qui n'a pas la classe 'd-none' (ou l'input courant)
    // Retirer la classe 'd-none' de l'input courant
    // this.InputTarget.classList.add();
    // this.InputTarget.classList.remove();
    this.currentStep++
    this.#setStepCount()
    if (this.#getPreviousInput()) this.#getPreviousInput().classList.add('d-none');
    if (this.#getNextInput()) this.#getNextInput().classList.remove('d-none');
    if (this.currentStep == this.stepsCount) {
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

  #setStepCount() {
    this.stepCountTarget.innerText = this.currentStep + '/' + this.stepsCount
  }
}
