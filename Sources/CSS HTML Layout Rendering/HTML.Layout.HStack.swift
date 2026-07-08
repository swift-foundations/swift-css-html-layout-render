//
//  HTML.Layout.HStack.swift
//  swift-css-html-layout-render
//

public import CSS_Standard
public import HTML_Rendering
import CSS_HTML_Rendering

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

        public var body: some HTML.View {
            ContentDivision { content }
                .css
                .alignItems(AlignItems.stretch)
                .verticalAlign(alignment)
                .display(Display.flex)
                .flexDirection(FlexDirection.row)
                .maxHeight(MaxHeight.percentage(100))
                .columnGap(ColumnGap.length(spacing == 0 ? .zero : spacing ?? 1.rem))
        }
    }
}

extension HTML.Layout.HStack: Sendable where Content: Sendable {}
