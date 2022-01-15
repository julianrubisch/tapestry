import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "overlay", "modal"]
  static classes = ["toggle", "overlayEntering", "overlayLeaving", "overlayVisible", "overlayInvisible", "modalEntering", "modalLeaving", "modalVisible", "modalInvisible"]
  static values = {
    enterTimeout: {default: 300},
    leaveTimeout: {default: 200}
  }

  open(e) {
    e.preventDefault()

    this.containerTarget.classList.remove(this.toggleClass)

    setTimeout(
      (() => {
        this.overlayTarget.setAttribute("aria-hidden", "false")
        this._show("overlay")
        this._show("modal")
      }).bind(this),
    )
  }

  close(e) {
    e.preventDefault()

    setTimeout(
      (() => {
        this.overlayTarget.setAttribute("aria-hidden", "true")
        this._hide("modal")
        this._hide("overlay")
      }).bind(this),
    )
  }

  _show(target) {
    this[`${target}Target`].classList.add(...this[`${target}EnteringClasses`])
    this[`${target}Target`].classList.remove(...this[`${target}InvisibleClasses`])
    this[`${target}Target`].classList.add(...this[`${target}VisibleClasses`])

    setTimeout(
      (() => {
        this[`${target}Target`].classList.remove(...this[`${target}EnteringClasses`])
      }).bind(this),
      this.enterTimeoutValue,
    )
  }

  _hide(target) {
    this[`${target}Target`].classList.add(...this[`${target}InvisibleClasses`])
    this[`${target}Target`].classList.remove(...this[`${target}VisibleClasses`])
    this[`${target}Target`].classList.add(...this[`${target}LeavingClasses`])

    setTimeout(
      (() => {
        this[`${target}Target`].classList.remove(...this[`${target}LeavingClasses`])
        this.containerTarget.classList.add(this.toggleClass)
      }).bind(this),
      this.leaveTimeoutValue,
    )
  }
}
