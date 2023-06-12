import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["cover1", "logo", "cover2", "cover3"]
  connect() {
  }

  goToNextCover(event) {
    console.log(event);
    this.logoTarget.classList.add("d-none");
    this.cover1Target.classList.remove("d-none");
 }
  goToNextCover2(event) {
    console.log(event);
    this.cover1Target.classList.add("d-none");
    this.cover2Target.classList.remove("d-none");
}

  goToNextCover3(event) {
    console.log(event);
    this.cover2Target.classList.add("d-none");
    this.cover3Target.classList.remove("d-none");
}
}
