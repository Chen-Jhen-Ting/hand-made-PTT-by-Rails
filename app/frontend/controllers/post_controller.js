

import { Controller } from "stimulus"
import Rails from '@rails/ujs'
export default class extends Controller{
  static targets = ["authorbye"]

  removeauthor () {
    this.authorbyeTarget.textContent= this.authorbyeTarget.textContent+"1";
  }
}



