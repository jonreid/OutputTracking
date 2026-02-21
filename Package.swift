// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "OutputTracking",
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
