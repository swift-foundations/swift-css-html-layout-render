//
//  HTML.Layout.Spacer.swift
//  swift-css-html-layout-render
//

import CSS_HTML_Rendering
import CSS_Standard
public import HTML_Rendering
import WHATWG_HTML_Grouping

extension HTML.Layout {
    public struct Spacer: HTML.View {
        public init() {}
    }
}

extension HTML.Layout.Spacer: Sendable {}

extension HTML.Layout.Spacer {
    public var body: some HTML.View {
        HTML.ContentDivision.Element {}
            .css
            .flexGrow(1)
    }
}
