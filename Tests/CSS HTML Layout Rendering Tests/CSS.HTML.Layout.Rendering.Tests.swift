//
//  CSS.HTML.Layout.Rendering.Tests.swift
//  swift-css-html-layout-render
//

import CSS_HTML_Layout_Rendering
import Testing

@Suite
struct CSSHTMLLayoutRenderingTests {
    @Test
    func `Spacer, HStack, and VStack construct and render`() {
        let spacer = HTML.Layout.Spacer()
        let hstack = HTML.Layout.HStack { spacer }
        let vstack = HTML.Layout.VStack { hstack }
        _ = vstack.body
    }
}
