# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "lit", to: "https://ga.jspm.io/npm:lit@2.0.2/index.js"
pin "@lit/reactive-element", to: "https://ga.jspm.io/npm:@lit/reactive-element@1.0.2/reactive-element.js"
pin "lit-element/lit-element.js", to: "https://ga.jspm.io/npm:lit-element@3.0.2/lit-element.js"
pin "lit-html", to: "https://ga.jspm.io/npm:lit-html@2.0.2/lit-html.js"
pin "lit/decorators.js", to: "https://ga.jspm.io/npm:lit@2.0.2/decorators.js"
pin "@lit/reactive-element/decorators/custom-element.js", to: "https://ga.jspm.io/npm:@lit/reactive-element@1.0.2/decorators/custom-element.js"
pin "@lit/reactive-element/decorators/event-options.js", to: "https://ga.jspm.io/npm:@lit/reactive-element@1.0.2/decorators/event-options.js"
pin "@lit/reactive-element/decorators/property.js", to: "https://ga.jspm.io/npm:@lit/reactive-element@1.0.2/decorators/property.js"
pin "@lit/reactive-element/decorators/query-all.js", to: "https://ga.jspm.io/npm:@lit/reactive-element@1.0.2/decorators/query-all.js"
pin "@lit/reactive-element/decorators/query-assigned-nodes.js", to: "https://ga.jspm.io/npm:@lit/reactive-element@1.0.2/decorators/query-assigned-nodes.js"
pin "@lit/reactive-element/decorators/query-async.js", to: "https://ga.jspm.io/npm:@lit/reactive-element@1.0.2/decorators/query-async.js"
pin "@lit/reactive-element/decorators/query.js", to: "https://ga.jspm.io/npm:@lit/reactive-element@1.0.2/decorators/query.js"
pin "@lit/reactive-element/decorators/state.js", to: "https://ga.jspm.io/npm:@lit/reactive-element@1.0.2/decorators/state.js"
pin "@svgdotjs/svg.js", to: "https://ga.jspm.io/npm:@svgdotjs/svg.js@3.1.1/dist/svg.esm.js"
pin "form-request-submit-polyfill", to: "https://ga.jspm.io/npm:form-request-submit-polyfill@2.0.0/form-request-submit-polyfill.js"
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/components", under: "components"
pin "@hotwired/turbo-rails", to: "turbo.js"
