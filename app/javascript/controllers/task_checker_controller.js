import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="task-checker"
export default class extends Controller {
  static targets = ['form']

  connect() {
    console.log(this)
  }

  done(event) {
    event.preventDefault;
    fetch(event.target.action, {
      method: "PATCH", // Could be dynamic with Stimulus values
      headers: { "Accept": "application/json" },
      body: new FormData(event.target)
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
      })
  }
}
