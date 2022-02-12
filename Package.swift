// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let sandbox = "SANDBOX"
let prod = "PROD"
let dev = "DEV"

let package = Package(
    name: "PreventorSDK",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PreventorSDK",
            targets: ["PreventorSDK", "DocumentReader", "RegulaCommon", "DocumentReaderCore"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "Alamofire", url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.5.0")),
        .package(name: "Lottie", url: "https://github.com/airbnb/lottie-ios.git", .exact("3.2.1"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "PreventorSDK",
            dependencies: ["Alamofire",
                           "Lottie",
                           "DocumentReader",
                           "RegulaCommon",
                           "DocumentReaderCore"],
            resources: [
                .process("Resources")
            ],
            swiftSettings: [
                .define(prod, .when(platforms: [.iOS], configuration: .release)),
                .define(dev, .when(platforms: [.iOS]))],
            linkerSettings: [.linkedFramework("DocumentReader"),
                             .linkedFramework("DocumentReaderCore"),
                             .linkedFramework("RegulaCommon")
                            ]
        ),
        .binaryTarget(name: "DocumentReaderCore",
                      url: "https://pods.regulaforensics.com/FullRFID/6.1.5791/DocumentReaderCore_fullrfid_6.1.5791.zip",
                      checksum: "2cac3da9baf9b8342113ee410b3f507a7991f833a6b95663bf7b1d48ad5b800f"),
        .binaryTarget(name: "DocumentReader",
                      url: "https://pods.regulaforensics.com/DocumentReader/6.1.2358/DocumentReader-6.1.2358.zip",
                      checksum: "98c369a20fd1f6cbde5e1282e3734a044f6a2217baeb95f0107856640afb21ea"),
        .binaryTarget(name: "RegulaCommon",
                      url: "https://pods.regulaforensics.com/RegulaCommon/6.1.102/RegulaCommon-6.1.102.zip",
                      checksum: "3d84f7a68029d4592cb1f707f7332a7cc62193b3dd8f81f897a5357c3a15aabf")
        
     //   .binaryTarget(name: "DocumentReader", path: "Frameworks/DocumentReader.xcframework"),
        //.binaryTarget(name: "RegulaCommon", path: "Frameworks/RegulaCommon.xcframework")
        
    ]
)
