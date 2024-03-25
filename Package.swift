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
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.5.0"),
        .package(url: "https://github.com/airbnb/lottie-ios.git", from: "3.2.0")
    ],
    targets: [
        .binaryTarget(name: "PreventorSDK", path: "PreventorSDK.xcframework"),
        .binaryTarget(name: "PSDKUIKit", path: "PSDKUIKit.xcframework"),
        .binaryTarget(name: "PSDKCommon", path: "PSDKCommon.xcframework"),
        .binaryTarget(name: "DocumentReaderCore",
                      url: "https://pods.regulaforensics.com/FullRFID/6.9.7953/DocumentReaderCore_fullrfid_6.9.7953.zip",
                      checksum: "56f8eb1dbdaf4732b8ae9afd5e9d941f3419e4f7efc8d27720f0d463f285d820"),
        .binaryTarget(name: "DocumentReader",
                      url: "https://pods.regulaforensics.com/DocumentReader/6.9.3102/DocumentReader-6.9.3102.zip",
                      checksum: "4ca53ad4ba3a76a72059aa53c415e8b67eafb41e3066f926e96650c3b8d7ad03"),
        .binaryTarget(name: "RegulaCommon",
                      url: "https://pods.regulaforensics.com/RegulaCommon/6.9.344/RegulaCommon-6.9.344.zip",
                      checksum: "d36a6649acc61187eea442a06ea4f3a8ba4e33daf735186e60489f621dd495a5")
    ],
    swiftLanguageVersions: [.v5]
)
