import Axis_Primitives
import CSS_HTML_Rendering
public import CSS_Standard
import Geometry_Primitives
public import HTML_Rendering
public import Layout_Primitives
import WHATWG_HTML_Grouping

public typealias LayoutRaw = Layout

extension LayoutRaw<W3C_CSS_Values.Length, CSSSpace>.Stack: @retroactive Render.View
where Content: HTML.View {}

extension LayoutRaw<W3C_CSS_Values.Length, CSSSpace>.Stack: @retroactive HTML.View
where Content: HTML.View {
    public var body: some HTML.View {
        if axis == .primary {

            HTML.ContentDivision.Element { content }
                .css
                .alignItems(alignment.cssAlignItems)
                .display(Display.flex)
                .flexDirection(FlexDirection.row)
                .columnGap(ColumnGap.length(spacing.value))
        } else {

            HTML.ContentDivision.Element { content }
                .css
                .alignItems(alignment.cssAlignItems)
                .display(Display.flex)
                .flexDirection(FlexDirection.column)
                .rowGap(RowGap.length(spacing.value))
        }
    }
}

extension Cross.Alignment {

    var cssAlignItems: AlignItems {
        switch self {
        case .leading: .flexStart
        case .center: .center
        case .trailing: .flexEnd
        case .fill: .stretch
        }
    }
}
