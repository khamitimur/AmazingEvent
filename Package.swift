// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "AmazingEvent",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v11),
        .tvOS(.v11),
        .watchOS(.v4)
    ],
    products: [
        .library(
            name: "AmazingEvent",
            targets: ["AmazingEvent"]),
    ],
    targets: [
        .target(
            name: "AmazingEvent",
            dependencies: [
                "AmazingWeakSequence"
            ]),
        .testTarget(
            name: "AmazingEventTests",
            dependencies: [
                "AmazingEvent"
            ]),
    ]
)
