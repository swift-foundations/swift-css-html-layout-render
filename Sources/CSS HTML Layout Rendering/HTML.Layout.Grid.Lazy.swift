public import Buffer_Linear_Primitive
public import CSS_HTML_Rendering
public import CSS_Standard
public import Column_Primitives
public import Dictionary_Ordered_Primitives
import HTML_Rendering
public import Hash_Indexed_Primitive
import Hash_Primitives
public import Layout_Primitives
public import Ownership_Shared_Primitive
import WHATWG_HTML_Grouping

extension HTML.Layout.Grid {
    public struct Lazy<Content: HTML.View>: HTML.View {
        public let columns: Breakpoints
        public let content: Content
        public let horizontalSpacing: W3C_CSS_Multicolumn.ColumnGap?
        public let verticalSpacing: W3C_CSS_Flexbox.RowGap?

        public init(
            columns: Breakpoints,
            horizontalSpacing: W3C_CSS_Multicolumn.ColumnGap? = nil,
            verticalSpacing: W3C_CSS_Flexbox.RowGap? = nil,
            @HTML.Builder content: () -> Content
        ) {
            self.columns = columns
            self.horizontalSpacing = horizontalSpacing
            self.verticalSpacing = verticalSpacing
            self.content = content()
        }

        public init(
            columns: Columns,
            horizontalSpacing: W3C_CSS_Multicolumn.ColumnGap? = nil,
            verticalSpacing: W3C_CSS_Flexbox.RowGap? = nil,
            @HTML.Builder content: () -> Content
        ) {
            var dict = Breakpoints()
            dict.set(nil as CSS_Standard.Media?, columns)
            self.columns = dict
            self.horizontalSpacing = horizontalSpacing
            self.verticalSpacing = verticalSpacing
            self.content = content()
        }

    }
}

extension HTML.Layout.Grid.Lazy: Sendable where Content: Sendable {}

extension HTML.Layout.Grid.Lazy {

    public typealias Columns = LayoutRaw<W3C_CSS_Values.Length, CSSSpace>.Grid<Content>.Lazy.Columns

    public typealias Breakpoints = __DictionaryOrdered<
        Ownership.Shared<
            Hash.Entry<CSS_Standard.Media?, Columns>,
            Hash.Indexed<Column_Primitives.Column.Heap<Hash.Entry<CSS_Standard.Media?, Columns>>>
        >
    >

    public var body: some HTML.View {
        let colValue: Columns =
            if !columns.isEmpty {
                columns.value(at: .zero)
            } else {
                .count(1)
            }
        let columnGap = horizontalSpacing == .zero ? .zero : horizontalSpacing
        let rowGap = verticalSpacing == .zero ? .zero : verticalSpacing
        let gridCols = colValue.cssGridTemplateColumns

        return HTML.ContentDivision.Element { content }
            .css
            .width(.percent(100))
            .display(.grid)
            .inlineStyle("grid-template-columns", gridCols)
            .columnGap(columnGap)
            .rowGap(rowGap)
    }
}

extension Layout.Grid.Lazy.Columns where Scalar == W3C_CSS_Values.Length {

    var cssGridTemplateColumns: String {
        switch self {
        case .count(let n):
            return "repeat(\(n), minmax(0, 1fr))"

        case .fractions(let values):
            return values.map { "minmax(0, \($0))" }.joined(separator: " ")

        case .autoFill(let minWidth):
            return "repeat(auto-fill, minmax(\(minWidth), 1fr))"

        case .autoFit(let minWidth):
            return "repeat(auto-fit, minmax(\(minWidth), 1fr))"
        }
    }
}
