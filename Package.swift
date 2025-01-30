// swift-tools-version:5.7.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PreventorSDK",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "PreventorSDK", targets: ["PreventorSDK",
                                                 "PSDKUIKit",
                                                 "PSDKCommon",
                                                 "PreventorSDKWrapper",
                                                 "PSDKUIKitWrapper",
                                                 "PSDKCommonWrapper"
                                                ])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.10.0"),
        .package(url: "https://github.com/airbnb/lottie-ios.git", from: "4.5.0"),
        .package(url: "https://github.com/regulaforensics/DocumentReader-Swift-Package", from: "7.5.4221"),
        .package(url: "https://github.com/regulaforensics/DocumentReaderFullRFID-Swift-Package", from: "7.5.11009")
        
    ],
    targets: [
        .binaryTarget(name: "PreventorSDK", path: "PreventorSDK.xcframework"),
        .binaryTarget(name: "PSDKUIKit", path: "PSDKUIKit.xcframework"),
        .binaryTarget(name: "PSDKCommon", path: "PSDKCommon.xcframework"),
        .target(
            name: "PreventorSDKWrapper",
            dependencies: [
                .target(name: "PreventorSDK"),
                .product(name: "DocumentReader", package: "documentreader-swift-package"),
                .product(name: "FullRFID", package: "documentreaderfullrfid-swift-package"),
                .product(name: "Alamofire", package: "alamofire")
            ],
            path: "PreventorSDKSources",
            sources: ["PreventorSDKDummy.swift"]
        ),
        .target(
            name: "PSDKUIKitWrapper",
            dependencies: [
                .target(name: "PSDKUIKit"),
                .product(name: "Lottie", package: "lottie-ios")
            ],
            path: "PSDKUIKitSources",
            sources: ["PSDKUIKitDummy.swift"]
        ),
        .target(
            name: "PSDKCommonWrapper",
            dependencies: [
                .product(name: "Alamofire", package: "alamofire")
            ],
            path: "PSDKCommonSources",
            sources: ["PSDKCommonDummy.swift"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
