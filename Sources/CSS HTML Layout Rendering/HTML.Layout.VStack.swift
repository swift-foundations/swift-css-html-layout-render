//
//  HTML.Layout.VStack.swift
//  swift-css-html-layout-render
//

public import CSS_Standard
public import HTML_Rendering
import CSS_HTML_Rendering

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

        public var body: some HTML.View {
            ContentDivision {
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
}

extension HTML.Layout.VStack: Sendable where Content: Sendable {}
