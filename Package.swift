// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "STB",
    products: [
        .library(name: "STB", targets: ["STB"]),
    ],
    targets: [
        .target(name: "CSTB"),
        .target(name: "STB", dependencies: ["CSTB"]),
        .testTarget(name: "STBTests", dependencies: ["STB"]),
    ]
)
