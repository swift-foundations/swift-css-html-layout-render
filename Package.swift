// swift-tools-version: 6.3.3

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
        .product(name: "Dictionary Ordered Primitives", package: "swift-dictionary-ordered-primitives")
    }
}

let package = Package(
    name: "swift-css-html-layout-render",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        .library(name: .cssHTMLLayoutRendering, targets: [.cssHTMLLayoutRendering]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-layout-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-css-html-render.git", branch: "main"),
        .package(url: "https://github.com/swift-standards/swift-css-standard.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-html-render.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-dictionary-ordered-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-ownership-shared-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-hash-table-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-hash-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-column-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-buffer-linear-primitives.git", branch: "main"),
    ],
    targets: [
        .target(
            name: .cssHTMLLayoutRendering,
            dependencies: [
                .layout,
                .cssHTMLRendering,
                .cssStandard,
                .htmlRendering,
                .dictionaryOrderedPrimitives,
                .sharedPrimitive,
                .hashIndexedPrimitive,
                .hashPrimitives,
                .columnPrimitives,
                .bufferLinearPrimitive,
            ]
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
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
