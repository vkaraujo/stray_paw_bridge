import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "content"]

  connect() {
    this.showTab(0) // show first tab on load
  }

  switch(event) {
    event.preventDefault()
    const index = this.tabTargets.indexOf(event.currentTarget)
    this.showTab(index)
  }

  showTab(index) {
    this.tabTargets.forEach((tab, i) => {
      tab.classList.toggle("border-b-2", i === index)
      tab.classList.toggle("border-blue-500", i === index)
      tab.classList.toggle("text-blue-500", i === index)
    })

    this.contentTargets.forEach((content, i) => {
      content.classList.toggle("hidden", i !== index)
    })
  }
}
