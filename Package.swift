// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CepteBulNetworking",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "CepteBulNetworking", targets: ["CepteBulNetworking"])
    ],
    targets: [
        .target(
            name: "CepteBulNetworking",
            path: "CepteBulNetworking"
        ),
        .testTarget(
            name: "CepteBulNetworkingTests",
            dependencies: ["CepteBulNetworking"],
            path: "Tests/CepteBulNetworkingTests"
        )
    ]
)
