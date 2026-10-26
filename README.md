# Feather Push Driver APNS

A push driver for the Feather CMS Push component using Swift APNS.

[![Release: 1.0.0-rc.1](https://img.shields.io/badge/Release-1.0.0--rc.1-F05138)](https://github.com/feather-framework/feather-push-driver-apns/releases/tag/1.0.0-rc.1)

## Requirements

![Swift 6.3+](https://img.shields.io/badge/Swift-6%2E3%2B-F05138)

- Swift 6.3+
- macOS 15+, iOS 18+, tvOS 18+, watchOS 11+, or visionOS 2+

## Getting started

⚠️ This repository is a work in progress, things can break until it reaches v1.0.0. 

Use at your own risk.

### Adding the dependency

To add a dependency on the package, declare it in your `Package.swift`:

```swift
.package(url: "https://github.com/feather-framework/feather-push-driver-apns.git", exact: "1.0.0-rc.1"),
```

and to your application target, add `FeatherPushDriverAPNS` to your dependencies:

```swift
.product(name: "FeatherPushDriverAPNS", package: "feather-push-driver-apns")
```

Example `Package.swift` file with `FeatherPushDriverAPNS` as a dependency:

```swift
// swift-tools-version:6.3
import PackageDescription

let package = Package(
    name: "my-application",
    dependencies: [
        .package(url: "https://github.com/feather-framework/feather-push-driver-apns.git", exact: "1.0.0-rc.1"),
    ],
    targets: [
        .target(name: "MyApplication", dependencies: [
            .product(name: "FeatherPushDriverAPNS", package: "feather-push-driver-apns")
        ]),
        .testTarget(name: "MyApplicationTests", dependencies: [
            .target(name: "MyApplication"),
        ]),
    ]
)
```
