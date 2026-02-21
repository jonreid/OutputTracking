// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "NetworkRequest",
    products: [
        .executable(name: "NetworkRequest", targets: ["NetworkRequest"]),
        .library(name: "NetworkRequestLibrary", targets: ["NetworkRequestLibrary"]),
    ],
    dependencies: [
        .package(path: "../")
    ],
    targets: [
        .executableTarget(
            name: "NetworkRequest",
            dependencies: ["NetworkRequestLibrary"]),
        .target(
            name: "NetworkRequestLibrary",
            dependencies: ["OutputTracking"]),
        .testTarget(
            name: "NetworkRequestTests",
            dependencies: ["NetworkRequestLibrary"]),
    ]
)
