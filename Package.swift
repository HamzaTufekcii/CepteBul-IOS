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
            path: "CepteBul",
            exclude: [
                "Assets.xcassets",
                "CepteBulApp.swift",
                "ContentView.swift",
                "Features",
                "MainTabView.swift",
                "HomeView.swift",
                "SearchView.swift",
                "ProfileView.swift"
            ]
        ),
        .testTarget(
            name: "CepteBulNetworkingTests",
            dependencies: ["CepteBulNetworking"],
            path: "CepteBulTests",
            exclude: ["CepteBulTests.swift"]
        )
    ]
)
