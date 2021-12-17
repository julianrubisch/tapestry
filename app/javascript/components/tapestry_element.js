import { LitElement, html, css } from "lit";
import { SVG, Rect } from "@svgdotjs/svg.js";

export default class TapestryElement extends LitElement {
  static get properties() {
    return {
      rows: { type: Number },
      maxDuration: { type: Number },
      activeId: { type: String },
      items: { type: Array },
      listId: { type: String }
    };
  }

  constructor() {
    super();

    this.rows = 6;
    this.maxDuration = 30;
    this.activeId = "0";
    this.items = [];
    this.listId = "0";
  }

  createRenderRoot() {
    return this;
  }

  firstUpdated() {
    this.setup();
    this.draw();

    this.activePlayableForm = document.querySelector(
      `#active_playable_list_${this.listId}`
    );
  }

  updated(changedProperties) {
    this.reset();
    this.draw();
  }

  setup() {
    this.svg = SVG()
      .addTo(this.renderRoot.querySelector(".svg-root"))
      .size("100%", "100%")
      .viewbox(0, 0, 100, 100);

    this.group = this.svg.group();
  }

  reset() {
    this.group.remove();
    this.group = this.svg.group();
  }

  draw() {
    this.transformedRows.forEach((row, index) => {
      let xTally = 0.0;
      row.forEach(item => {
        const rect = this.group
          .rect(item.duration * 100 - 4, 100 / this.rows - 4)
          .fill(item.color)
          .x(xTally + 2)
          .y((index * 100) / this.rows + 2)
          .attr("style", "cursor: pointer;")
          .click(e => {
            e.preventDefault();
            this.activePlayableForm.querySelector(
              `#list_active_playable_id`
            ).value = item.id;
            this.activePlayableForm.requestSubmit();
          });

        if (item.id == this.activeId) {
          rect
            .animate(1200, 0, "now")
            .ease("<>")
            .loop(Infinity, true)
            .attr("opacity", 0.3);
        } else {
          rect.attr("opacity", 0.75);
        }

        xTally = xTally + item.duration * 100;
      });
    });
  }

  render() {
    return html`
      <div class="svg-root"></div>
    `;
  }

  get transformedRows() {
    const chunkedRows = splitIntoChunks(
      this.items.map(item => ({
        ...item,
        duration: item.duration / this.rowWidth
      }))
    );
    return chunkedRows;
  }

  get rowWidth() {
    return this.maxDuration / this.rows;
  }
}

customElements.define("tapestry-element", TapestryElement);

const splitIntoChunks = items =>
  items.reduce((memo, item) => processItem(memo, item), [[]]);

const processItem = (memo, item) => {
  const lastMemoItem = memo[memo.length - 1];

  if (sum([...lastMemoItem.map(elem => elem.duration), item.duration]) > 1) {
    const current = {
      ...item,
      duration: Math.min(
        1 - sum(lastMemoItem.map(elem => elem.duration)),
        item.duration
      )
    };
    const remainder = { ...item, duration: item.duration - current.duration };

    lastMemoItem.push(current);
    memo.push([]);

    // recurse
    memo = processItem(memo, remainder);
  } else {
    lastMemoItem.push(item);
  }
  return memo;
};

const sum = items => items.reduce((memo, item) => memo + item, 0);
