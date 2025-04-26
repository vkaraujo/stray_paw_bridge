import { Application } from "@hotwired/stimulus"

const application = Application.start()

application.debug = false
window.Stimulus   = application

export { application }

import CarouselController from "./carousel_controller"
application.register("carousel", CarouselController)

import TabController from "./tab_controller"
application.register("tab", TabController)