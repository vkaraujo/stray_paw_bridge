import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

// Register the carousel controller only
import CarouselController from "./carousel_controller"
application.register("carousel", CarouselController)
