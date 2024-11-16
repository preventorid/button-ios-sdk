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
                                                 "DocumentReaderCore",
                                                 "DocumentReader",
                                                 "RegulaCommon"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.10.0"),
        .package(url: "https://github.com/airbnb/lottie-ios.git", from: "4.5.0")
    ],
    targets: [
        .binaryTarget(name: "PreventorSDK", path: "PreventorSDK.xcframework"),
        .binaryTarget(name: "PSDKUIKit", path: "PSDKUIKit.xcframework"),
        .binaryTarget(name: "PSDKCommon", path: "PSDKCommon.xcframework"),
        .binaryTarget(name: "DocumentReaderCore",
                      url: "https://pods.regulaforensics.com/FullRFID/7.4.9816/DocumentReaderCore_fullrfid_7.4.9816.zip",
                      checksum: "2402d95fd5d2f8443372fe89e22b67099ae01b8f6c6da3ed7c5256f798b7550a"),
        .binaryTarget(name: "DocumentReader",
                      url: "https://pods.regulaforensics.com/DocumentReader/7.4.3900/DocumentReader-7.4.3900.zip",
                      checksum: "da2a869525157c9a2dcfaefbc5107c2281dce0126d3a3577195ccecaf4c9104d"),
        .binaryTarget(name: "RegulaCommon",
                      url: "https://pods.regulaforensics.com/RegulaCommon/7.4.795/RegulaCommon-7.4.795.zip",
                      checksum: "54bb273db69e677c9fa0c4bf8be6294acf1be37ef0ba953680475f9e4bf436ed")
    ],
    swiftLanguageVersions: [.v5]
)
