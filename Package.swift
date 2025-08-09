// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CepteBul",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "CepteBul", targets: ["CepteBul"])
    ],
    targets: [
        .target(
            name: "CepteBul",
            path: "CepteBul",
            exclude: [
                "Assets.xcassets",
                "CepteBulApp.swift",
                "ContentView.swift",
                "Features"
            ]
        ),
        .testTarget(
            name: "CepteBulTests",
            dependencies: ["CepteBul"],
            path: "CepteBulTests",
            exclude: ["CepteBulTests.swift"]
        )
    ]
)
