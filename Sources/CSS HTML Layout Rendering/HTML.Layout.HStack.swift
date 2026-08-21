import CSS_HTML_Rendering
public import CSS_Standard
public import HTML_Rendering
import WHATWG_HTML_Grouping

extension HTML.Layout {
    public struct HStack<Content: HTML.View>: HTML.View {
        public let alignment: VerticalAlign
        public let spacing: CSS_Standard.Length?
        public let content: Content

        public init(
            alignment: VerticalAlign = .middle,
            spacing: CSS_Standard.Length? = nil,
            @HTML.Builder content: () -> Content
        ) {
            self.alignment = alignment
            self.spacing = spacing
            self.content = content()
        }

    }
}

extension HTML.Layout.HStack: Sendable where Content: Sendable {}

extension HTML.Layout.HStack {
    public var body: some HTML.View {
        HTML.ContentDivision.Element { content }
            .css
            .alignItems(AlignItems.stretch)
            .verticalAlign(alignment)
            .display(Display.flex)
            .flexDirection(FlexDirection.row)
            .maxHeight(MaxHeight.percentage(100))
            .columnGap(ColumnGap.length(spacing == 0 ? .zero : spacing ?? 1.rem))
    }
}
