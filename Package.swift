// swift-tools-version: 5.4

import PackageDescription

let package = Package(
	name: "DSFDropFilesView",
	platforms: [
		.macOS(.v10_13)
	],
	products: [
		.library(name: "DSFDropFilesView", targets: ["DSFDropFilesView"]),
		.library(name: "DSFDropFilesView-static", type: .static, targets: ["DSFDropFilesView"]),
		.library(name: "DSFDropFilesView-shared", type: .dynamic, targets: ["DSFDropFilesView"]),
	],
	dependencies: [
		.package(url: "https://github.com/dagronf/DSFAppearanceManager", from: "3.4.2")
	],
	targets: [
		.target(
			name: "DSFDropFilesView",
			dependencies: [
				.product(name: "DSFAppearanceManager", package: "DSFAppearanceManager")
			]
		),
		.testTarget(
			name: "DSFDropFilesViewTests",
			dependencies: ["DSFDropFilesView"]),
	]
)
