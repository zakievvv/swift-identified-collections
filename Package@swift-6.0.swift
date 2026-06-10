// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "swift-identified-collections",
  // Xcode 27 / SPM compatibility — see the matching comment in
  // zakievvv/swift-collections's Package.swift. Without an explicit
  // `platforms:` declaration, SPM falls back to its hardcoded 8.0 default
  // for watchOS and Xcode 27 refuses to resolve. Consumer-side overrides
  // don't propagate to SPM-embedded projects, so the floor lives here.
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15),
    .tvOS(.v13),
    .watchOS(.v6),
  ],
  products: [
    .library(
      name: "IdentifiedCollections",
      targets: ["IdentifiedCollections"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-collections", from: "1.0.2"),
    .package(url: "https://github.com/apple/swift-collections-benchmark", from: "0.0.2"),
  ],
  targets: [
    .target(
      name: "IdentifiedCollections",
      dependencies: [
        .product(name: "OrderedCollections", package: "swift-collections")
      ]
    ),
    .testTarget(
      name: "IdentifiedCollectionsTests",
      dependencies: ["IdentifiedCollections"]
    ),
    .executableTarget(
      name: "swift-identified-collections-benchmark",
      dependencies: [
        "IdentifiedCollections",
        .product(name: "CollectionsBenchmark", package: "swift-collections-benchmark"),
      ]
    ),
  ],
  swiftLanguageModes: [.v6]
)

#if !os(Windows)
  // DocC needs to be ported to Windows
  // https://github.com/thebrowsercompany/swift-build/issues/39
  package.dependencies.append(
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
  )
#endif
