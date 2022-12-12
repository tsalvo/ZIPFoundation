// swift-tools-version:5.6
import PackageDescription

#if canImport(Compression)
let targets: [Target] = [
    .target(name: "ZIPFoundation"),
    .testTarget(name: "ZIPFoundationTests", dependencies: ["ZIPFoundation"])
]
#else
let targets: [Target] = [
    .systemLibrary(name: "CZLib", pkgConfig: "zlib", providers: [.brew(["zlib"]), .apt(["zlib"])]),
    .target(name: "ZIPFoundation", dependencies: ["CZLib"], cSettings: [.define("_GNU_SOURCE", to: "1")]),
    .testTarget(name: "ZIPFoundationTests", dependencies: ["ZIPFoundation"])
]
#endif

let package = Package(
    name: "ZIPFoundation",
    platforms: [
        .iOS("15.2"), .macCatalyst("14.0")
    ],
    products: [
        .library(name: "ZIPFoundation", targets: ["ZIPFoundation"])
    ],
    targets: targets,
    swiftLanguageVersions: [.v4, .v4_2, .v5]
)
