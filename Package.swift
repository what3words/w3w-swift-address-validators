// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "w3w-swift-address-validators",
    platforms: [
      .macOS(.v10_11), .iOS(.v9), .tvOS(.v9), .watchOS(.v2)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "W3WSwiftAddressValidators",
            targets: ["W3WSwiftAddressValidators"]),
    ],
    dependencies: [
      .package(url: "https://github.com/what3words/w3w-swift-wrapper.git", "3.7.2"..<"4.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite. Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "W3WSwiftAddressValidators",
            dependencies: [
              .product(name: "W3WSwiftApi", package: "w3w-swift-wrapper"),
            ]),
        .testTarget(
            name: "w3w-swift-street-addressesTests",
            dependencies: ["W3WSwiftAddressValidators"]),
    ]
)
