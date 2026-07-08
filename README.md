# swift-css-html-layout-render

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

SwiftUI-style layout views for HTML — `HStack`, `VStack`, `Spacer`, and a lazy grid — built by adapting the `Layout Primitives` algebra to CSS coordinate space.

---

## Key Features

- **Layout as a shed facet** — layout composition is orthogonal to CSS-property rendering. This package carries the SwiftUI-style layout views so the base `CSS HTML Rendering` stays a single-concern property renderer.
- **Adapts the L1 algebra** — the layout containers specialize `Layout<W3C_CSS_Values.Length, CSSSpace>` from `Layout Primitives`; the conformed `Layout.Stack` renders directly as an `HTML.View`.
- **Nested namespace** — the containers live under `HTML.Layout.*` (`HTML.Layout.VStack`, `HTML.Layout.HStack`, `HTML.Layout.Spacer`, `HTML.Layout.Grid.Lazy`).
- **Source-compatible spellings** — top-level `VStack`, `HStack`, `Spacer`, and `LazyVGrid` remain available for existing call sites.

---

## Quick Start

```swift
import CSS_HTML_Layout_Rendering

let row = HStack {
    Spacer()
}

let column = VStack(spacing: .rem(1)) {
    div { "First" }
    div { "Second" }
}
```

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-foundations/swift-css-html-layout-render.git", branch: "main")
]
```

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "CSS HTML Layout Rendering", package: "swift-css-html-layout-render"),
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26.

---

## Architecture

The package depends on `Layout Primitives` (L1, the shared layout algebra) and `CSS HTML Rendering` (L3, the CSS-property renderer it composes). Consumers reach these views transparently via `import HTML` — the `CSS` module re-exports this module alongside `CSS HTML Rendering`.

---

## Community

<!-- BEGIN: discussion -->
*Discussion thread will be created at first public release.*
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE](LICENSE.md).
