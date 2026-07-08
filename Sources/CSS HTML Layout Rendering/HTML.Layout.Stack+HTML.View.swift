//
//  HTML.Layout.Stack+HTML.View.swift
//  swift-css-html-layout-render
//
//  Adapts the L1 `Layout.Stack` algebra (from `Layout Primitives`) to CSS
//  coordinate space and conforms it to `HTML.View` — mirroring the PDF
//  adapter (`PDF.Stack+PDF.View.swift`). The adapter reads the L1 struct's
//  public stored fields directly rather than re-declaring them.
//

import Axis_Primitives
import Geometry_Primitives
public import Layout_Primitives
public import CSS_Standard
public import HTML_Rendering
import CSS_HTML_Rendering

// MARK: - Layout alias (sidesteps the `HTML.Layout` name shadow)

public typealias LayoutRaw = Layout

// MARK: - HTML.View conformance for the L1 Stack

// `HTML.View` refines `Render.View`; a conditional conformance must state the
// inherited protocol explicitly. `Render.View`'s `body` witness comes from the
// `HTML.View` conformance below and `_render` from its protocol-extension default.
extension LayoutRaw<W3C_CSS_Values.Length, CSSSpace>.Stack: @retroactive Render.View
where Content: HTML.View {}

extension LayoutRaw<W3C_CSS_Values.Length, CSSSpace>.Stack: @retroactive HTML.View where Content: HTML.View {
    public var body: some HTML.View {
        if axis == .primary {
            // horizontal
            ContentDivision { content }
                .css
                .alignItems(alignment.cssAlignItems)
                .display(Display.flex)
                .flexDirection(FlexDirection.row)
                .columnGap(ColumnGap.length(spacing.value))
        } else {
            // vertical
            ContentDivision { content }
                .css
                .alignItems(alignment.cssAlignItems)
                .display(Display.flex)
                .flexDirection(FlexDirection.column)
                .rowGap(RowGap.length(spacing.value))
        }
    }
}

// MARK: - Cross.Alignment → CSS align-items

extension Cross.Alignment {
    /// The CSS `align-items` value for this cross-axis alignment.
    var cssAlignItems: AlignItems {
        switch self {
        case .leading: .flexStart
        case .center: .center
        case .trailing: .flexEnd
        case .fill: .stretch
        }
    }
}
