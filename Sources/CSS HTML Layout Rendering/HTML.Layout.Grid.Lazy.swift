//
//  HTML.Layout.Grid.Lazy.swift
//  swift-css-html-layout-render
//
//  The responsive column-template grid (formerly the top-level `LazyVGrid`),
//  re-nested under `HTML.Layout.Grid.Lazy` to mirror the L1 `Layout.Grid.Lazy`
//  shape. Reuses the L1 `Columns` sizing enum verbatim.
//

public import Buffer_Linear_Primitive
public import CSS_Standard
public import Column_Primitives
public import Dictionary_Ordered_Primitives
public import HTML_Rendering
public import Hash_Indexed_Primitive
public import Hash_Primitives
public import Layout_Primitives
public import Ownership_Shared_Primitive
public import CSS_HTML_Rendering

extension HTML.Layout.Grid {
    public struct Lazy<Content: HTML.View>: HTML.View {
        /// Column configuration type parameterized by CSS Length
        public typealias Columns = LayoutRaw<W3C_CSS_Values.Length, CSSSpace>.Grid<Content>.Lazy.Columns

        /// The responsive column configuration: a value-semantic (copy-on-write)
        /// insertion-ordered map from an optional media-query breakpoint (`nil` = the
        /// default, no media query) to its `Columns`, on the `Shared` column.
        public typealias Breakpoints = __DictionaryOrdered<
            Ownership.Shared<
                Hash.Entry<CSS_Standard.Media?, Columns>,
                Hash.Indexed<Column_Primitives.Column.Heap<Hash.Entry<CSS_Standard.Media?, Columns>>>
            >
        >

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

        /// Convenience initializer with single column configuration (no media queries)
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

            ContentDivision { content }
                .css
                .width(.percent(100))
                .display(.grid)
                .inlineStyle("grid-template-columns", gridCols)
                .columnGap(columnGap)
                .rowGap(rowGap)
        }
    }
}

extension HTML.Layout.Grid.Lazy: Sendable where Content: Sendable {}

// MARK: - CSS Rendering for Layout.Grid.Lazy.Columns

extension Layout.Grid.Lazy.Columns where Scalar == W3C_CSS_Values.Length {
    /// Converts the column configuration to a CSS grid-template-columns value
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
