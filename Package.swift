// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KeychainKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "KeychainKit",
            targets: ["KeychainKit"]
        ),
    ],
    targets: [
        .target(
            name: "KeychainKit"
        ),
        .testTarget(
            name: "KeychainKitTests",
            dependencies: ["KeychainKit"]
        ),
    ]
)
