import CSS_HTML_Layout_Rendering
import HTML_Rendering
import Testing

@Suite
struct `CSS HTML Layout Rendering Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `CSS HTML Layout Rendering Tests`.Integration {
    @Test
    func `Spacer, HStack, and VStack construct and render`() {
        let spacer = HTML.Layout.Spacer()
        let hstack = HTML.Layout.HStack { spacer }
        let vstack = HTML.Layout.VStack { hstack }
        _ = vstack.body
    }
}
