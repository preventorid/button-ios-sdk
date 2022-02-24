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
        .library(name: "PreventorSDK", targets: ["PreventorSDKWrapper"])
        
    ],
    dependencies: [
        // .package(url: /* package url */, from: "1.0.0"),
        // .package(name: "Alamofire", url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.5.0")),
        // .package(name: "Lottie", url: "https://github.com/airbnb/lottie-ios.git", .upToNextMajor(from: "3.2.1"))
    ],
    targets: [
        .target(name: "PreventorSDKWrapper",
                dependencies: [
                    .target(name: "PreventorSDK", condition: .when(platforms: [.iOS])),
                    .target(name: "DocumentReaderCore", condition: .when(platforms: [.iOS])),
                    .target(name: "DocumentReader", condition: .when(platforms: [.iOS])),
                    .target(name: "RegulaCommon", condition: .when(platforms: [.iOS]))],
                path: "PreventorSDKWrapper",
                swiftSettings: [.define("BUILD_LIBRARY_FOR_DISTRIBUTION=YES")]),
        .binaryTarget(name: "PreventorSDK", path: "PreventorSDK.xcframework"),
        .binaryTarget(name: "DocumentReaderCore",
                      url: "https://pods.regulaforensics.com/FullRFID/6.1.5791/DocumentReaderCore_fullrfid_6.1.5791.zip",
                      checksum: "2cac3da9baf9b8342113ee410b3f507a7991f833a6b95663bf7b1d48ad5b800f"),
        .binaryTarget(name: "DocumentReader",
                      url: "https://pods.regulaforensics.com/DocumentReader/6.1.2358/DocumentReader-6.1.2358.zip",
                      checksum: "98c369a20fd1f6cbde5e1282e3734a044f6a2217baeb95f0107856640afb21ea"),
        .binaryTarget(name: "RegulaCommon",
                      url: "https://pods.regulaforensics.com/RegulaCommon/6.1.102/RegulaCommon-6.1.102.zip",
                      checksum: "3d84f7a68029d4592cb1f707f7332a7cc62193b3dd8f81f897a5357c3a15aabf")
    ],
    swiftLanguageVersions: [.v5]
)
