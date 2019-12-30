// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PLOP",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "PLOP",
            targets: ["PLOP"])
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick", from: "2.1.0"),
        .package(url: "https://github.com/Quick/Nimble", from: "8.0.2")
    ],
    targets: [
        .target(
            name: "PLOP",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "PLOPTests",
            dependencies: [
                "PLOP"
            ],
            path: "Tests")
    ]
)
