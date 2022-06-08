import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "fieldvalue", "fieldcaption"]

  numberic_filter({ params }) {
    console.log(`field ${ params.field }`)

    var myModal = new bootstrap.Modal(this.modalTarget)
    this.fieldvalueTarget.id = params.field
    this.fieldvalueTarget.name = params.field
    this.fieldcaptionTarget.innerText = params.field
    myModal.show()
  }
}
