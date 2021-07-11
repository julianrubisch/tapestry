import { LitElement, html, css } from "lit";
import { customElement, property } from "lit/decorators.js";

// @customElement("tapestry-element")
export default class TapestryElement extends LitElement {
  connectedCallback() {
    super.connectedCallback();

    console.log("connected");
  }

  render() {
    return html`
      Test
    `;
  }
}

customElements.define("tapestry-element", TapestryElement);
