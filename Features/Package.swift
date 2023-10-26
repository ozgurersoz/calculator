// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "CalculatorFeature", targets: ["CalculatorFeature"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "CalculatorFeature",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                .target(name: "DataSource"),
                .target(name: "UIComponents")
            ],
            path: "Sources/CalculatorFeature/Sources"
        ),
        .testTarget(
            name: "CalculatorFeatureTests",
            dependencies: ["CalculatorFeature"],
            path: "Sources/CalculatorFeature/Tests"
        ),
        .target(
            name: "DataSource",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies")
            ]
        ),
        .target(
            name: "UIComponents",
            path: "Sources/UIComponents/Sources"
        )
    ]
)
