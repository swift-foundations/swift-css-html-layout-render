//
//  HTML.Layout.Spacer.swift
//  swift-css-html-layout-render
//

import CSS_Standard
public import HTML_Rendering
import CSS_HTML_Rendering

extension HTML.Layout {
    public struct Spacer: HTML.View {
        public init() {}

        public var body: some HTML.View {
            ContentDivision {}
                .css
                .flexGrow(1)
        }
    }
}

extension HTML.Layout.Spacer: Sendable {}
