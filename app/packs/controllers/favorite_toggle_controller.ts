import { Controller } from "stimulus"

export default class FavoriteToggleController extends Controller {
  static classes = ["hidden"]
  hiddenClass: string

  static targets = ["elementToHide", "elementWithText"]
  elementToHideTarget: HTMLElement
  elementWithTextTarget: HTMLElement

  static values = { visible: Boolean }
  visibleValue: boolean

  toggle(): void {
    this.flipState()
  }

  flipState(): void {
    this.visibleValue = !this.visibleValue
  }

  // this is will auto connect and listen visibleValue when changed
  visibleValueChanged(): void {
    this.updateHiddenClass()
    this.updateText()
  }

  updateHiddenClass(): void {
    this.elementToHideTarget.classList.toggle("hidden", !this.visibleValue)
  }

  newText(): string {
    return this.visibleValue ? "Hide" : "Show"
  }

  updateText(): void {
    this.elementWithTextTarget.innerText = this.newText()
  }
}
