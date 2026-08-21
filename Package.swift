// swift-tools-version: 6.4

import PackageDescription

extension String {
    static let cssHTMLLayoutRendering: Self = "CSS HTML Layout Rendering"
    var tests: Self { self + " Tests" }
}

extension Target.Dependency {
    static var cssHTMLLayoutRendering: Self { .target(name: .cssHTMLLayoutRendering) }
}

extension Target.Dependency {
    static var layout: Self {
        .product(name: "Layout Primitives", package: "swift-layout-primitives")
    }
    static var cssHTMLRendering: Self {
        .product(name: "CSS HTML Rendering", package: "swift-css-html-render")
    }
    static var cssStandard: Self {
        .product(name: "CSS Standard", package: "swift-css-standard")
    }
    static var htmlRendering: Self {
        .product(name: "HTML Rendering", package: "swift-html-render")
    }
    static var whatwgHTMLGrouping: Self {
        .product(name: "WHATWG HTML Grouping", package: "swift-whatwg-html")
    }
    static var sharedPrimitive: Self {
        .product(name: "Ownership Shared Primitive", package: "swift-ownership-shared-primitives")
    }
    static var hashIndexedPrimitive: Self {
        .product(name: "Hash Indexed Primitive", package: "swift-hash-table-primitives")
    }
    static var hashPrimitives: Self {
        .product(name: "Hash Primitives", package: "swift-hash-primitives")
    }
    static var columnPrimitives: Self {
        .product(name: "Column Primitives", package: "swift-column-primitives")
    }
    static var bufferLinearPrimitive: Self {
        .product(name: "Buffer Linear Primitive", package: "swift-buffer-linear-primitives")
    }
    static var dictionaryOrderedPrimitives: Self {
        .product(
            name: "Dictionary Ordered Primitives",
            package: "swift-dictionary-ordered-primitives"
        )
    }
}

let package = Package(
    name: "swift-css-html-layout-render",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: .cssHTMLLayoutRendering, targets: [.cssHTMLLayoutRendering])
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-primitives/swift-layout-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-foundations/swift-css-html-render.git",
            branch: "main"
        ),
        .package(url: "https://github.com/swift-standards/swift-css-standard.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-html-render.git", branch: "main"),
        .package(url: "https://github.com/swift-whatwg/swift-whatwg-html.git", branch: "main"),
        .package(
            url: "https://github.com/swift-primitives/swift-dictionary-ordered-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-ownership-shared-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-hash-table-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-hash-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-column-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-buffer-linear-primitives.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: .cssHTMLLayoutRendering,
            dependencies: [
                .layout,
                .cssHTMLRendering,
                .cssStandard,
                .htmlRendering,
                .whatwgHTMLGrouping,
                .dictionaryOrderedPrimitives,
                .sharedPrimitive,
                .hashIndexedPrimitive,
                .hashPrimitives,
                .columnPrimitives,
                .bufferLinearPrimitive,
            ]
        ),
        .testTarget(
            name: .cssHTMLLayoutRendering.tests,
            dependencies: [
                .cssHTMLLayoutRendering
            ],
            path: "Tests/CSS HTML Layout Rendering Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
