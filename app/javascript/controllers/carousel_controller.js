import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["track"]

  connect() {
    this.index = 0
    this.itemWidth = this.trackTarget.querySelector("div").offsetWidth
    this.totalItems = this.trackTarget.children.length
    this.visible = 3
  }

  next() {
    this.index += this.visible
    if (this.index >= this.totalItems) this.index = 0
    this.update()
  }

  prev() {
    this.index -= this.visible
    if (this.index < 0) {
      const maxIndex = Math.floor((this.totalItems - 1) / this.visible) * this.visible
      this.index = maxIndex
    }
    this.update()
  }

  update() {
    const offset = this.index * this.itemWidth
    this.trackTarget.style.transform = `translateX(-${offset}px)`
  }
}
