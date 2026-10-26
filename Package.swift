// swift-tools-version:6.3
import PackageDescription

let swiftSettings: [SwiftSetting] = [
    .swiftLanguageMode(.v6),
    .strictMemorySafety(),
    .treatAllWarnings(as: .error),
    .enableUpcomingFeature("InternalImportsByDefault"),
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("MemberImportVisibility"),
    .enableUpcomingFeature("InferIsolatedConformances"),
    .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
    .enableUpcomingFeature("ImmutableWeakCaptures"),
    .enableExperimentalFeature("SuppressedAssociatedTypes"),
    .enableExperimentalFeature("LifetimeDependence"),
    .enableExperimentalFeature("Lifetimes"),
    .enableUpcomingFeature("StrictConcurrency"),
]

let package = Package(
    name: "feather-push-driver-apns",
    platforms: [
        .macOS(.v15),
        .iOS(.v18),
        .tvOS(.v18),
        .watchOS(.v11),
        .visionOS(.v2),
    ],
    products: [
        .library(
            name: "FeatherPushDriverAPNS",
            targets: ["FeatherPushDriverAPNS"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-server-community/APNSwift.git",
            from: "5.0.0"
        ),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.62.0"),
        .package(
            url: "https://github.com/feather-framework/feather-push.git",
            exact: "1.0.0-rc.1"
        ),
    ],
    targets: [
        .target(
            name: "FeatherPushDriverAPNS",
            dependencies: [
                .product(name: "FeatherPush", package: "feather-push"),
                .product(name: "APNS", package: "APNSwift"),
                .product(name: "APNSCore", package: "APNSwift"),
                .product(name: "NIOCore", package: "swift-nio"),
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "FeatherPushDriverAPNSTests",
            dependencies: [
                .product(name: "FeatherPush", package: "feather-push"),
                .target(name: "FeatherPushDriverAPNS"),
            ],
            swiftSettings: swiftSettings
        ),
    ]
)
