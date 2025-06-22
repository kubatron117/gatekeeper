import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["list", "template"]
    add(event) {
        event.preventDefault()
        const time = new Date().getTime()
        const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, time)
        this.listTarget.insertAdjacentHTML("beforeend", content)
    }

    remove(event) {
        event.preventDefault()
        const wrapper = event.currentTarget.closest(".nested-fields")
        const destroyInput = wrapper.querySelector("input[type='checkbox'][name*='_destroy']")

        if (destroyInput) {
            destroyInput.checked = true
            wrapper.style.display = "none"
        } else {
            wrapper.remove()
        }
    }
}
