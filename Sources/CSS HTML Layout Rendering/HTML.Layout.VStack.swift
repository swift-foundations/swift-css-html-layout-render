import CSS_HTML_Rendering
public import CSS_Standard
public import HTML_Rendering
import WHATWG_HTML_Grouping

extension HTML.Layout {
    public struct VStack<Content: HTML.View>: HTML.View {
        public let alignment: AlignItems
        public let spacing: CSS_Standard.Length?
        public let content: Content

        public init(
            alignment: AlignItems = .stretch,
            spacing: CSS_Standard.Length? = nil,
            @HTML.Builder content: () -> Content
        ) {
            self.alignment = alignment
            self.spacing = spacing
            self.content = content()
        }

    }
}

extension HTML.Layout.VStack: Sendable where Content: Sendable {}

extension HTML.Layout.VStack {
    public var body: some HTML.View {
        HTML.ContentDivision.Element {
            content
        }
        .css
        .alignItems(alignment)
        .display(Display.flex)
        .flexDirection(FlexDirection.column)
        .maxWidth(MaxWidth.percentage(100))
        .rowGap(RowGap.length(spacing == .zero ? .zero : (spacing ?? 1.rem)))
    }
}
