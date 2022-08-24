// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "DSFDropFilesView",
	platforms: [
		.macOS(.v10_11)
	],
	products: [
		.library(
			name: "DSFDropFilesView",
			type: .static,
			targets: ["DSFDropFilesView"]),
		.library(
			name: "DSFDropFilesViewDynamic",
			type: .dynamic,
			targets: ["DSFDropFilesView"]),
	],
	dependencies: [
		.package(url: "https://github.com/dagronf/DSFAppearanceManager", from: "3.0.0")
	],
	targets: [
		.target(
			name: "DSFDropFilesView",
			dependencies: [
				// Make sure that we link against the static library
				.product(name: "DSFAppearanceManager", package: "DSFAppearanceManager")
			]
		),
		.testTarget(
			name: "DSFDropFilesViewTests",
			dependencies: ["DSFDropFilesView"]),
	]
)
