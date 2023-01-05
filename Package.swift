// swift-tools-version:5.5
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
                                                 "Lottie",
                                                 "Alamofire",
                                                 "PSDKUIKit",
                                                 "PSDKServices",
                                                 "PSDKCommon",
                                                 "DocumentReaderCore",
                                                 "DocumentReader",
                                                 "RegulaCommon"])
    ],
    dependencies: [],
    targets: [
        .binaryTarget(name: "PreventorSDK", path: "PreventorSDK.xcframework"),
        .binaryTarget(name: "Lottie", path: "Lottie.xcframework"),
        .binaryTarget(name: "Alamofire", path: "Alamofire.xcframework"),
        .binaryTarget(name: "PSDKUIKit", path: "PSDKUIKit.xcframework"),
        .binaryTarget(name: "PSDKServices", path: "PSDKServices.xcframework"),
        .binaryTarget(name: "PSDKCommon", path: "PSDKCommon.xcframework"),
        .binaryTarget(name: "DocumentReaderCore",
                      url: "https://pods.regulaforensics.com/FullRFID/6.6.6999/DocumentReaderCore_fullrfid_6.6.6999.zip",
                      checksum: "a113b2c9dbd158fc63ae136d98e1bf412c502def3a6e5bec3cb88fb3c1ea6b46"),
        .binaryTarget(name: "DocumentReader",
                      url: "https://pods.regulaforensics.com/DocumentReader/6.6.2753/DocumentReader-6.6.2753.zip",
                      checksum: "4ca53ad4ba3a76a72059aa53c415e8b67eafb41e3066f926e96650c3b8d7ad03"),
        .binaryTarget(name: "RegulaCommon",
                      url: "https://pods.regulaforensics.com/RegulaCommon/6.6.203/RegulaCommon-6.6.203.zip",
                      checksum: "7f8a23d5ea9d3208123953a651b1376d166944400eb6c833eee1e35d6a21fd99")
    ],
    swiftLanguageVersions: [.v5]
)
