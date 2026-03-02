// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "OutputTracking",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .watchOS(.v6),
        .tvOS(.v13)
    ],
    products: [
        .library(
            name: "OutputTracking",
            targets: ["OutputTracking"]),
    ],
    targets: [
        .target(
            name: "OutputTracking"),
        .testTarget(
            name: "OutputTrackingTests",
            dependencies: ["OutputTracking"]
        ),
    ]
)
