//
//  DSFDropFilesView+SwiftUI.swift
//
//  Copyright © 2020 Darren Ford. All rights reserved.
//
//  MIT License
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#if canImport(SwiftUI) && os(macOS)

import SwiftUI

@available(macOS 10.15, *)
public extension DSFDropFilesView {
	/// A SwiftUI wrapper for DSFDropFilesView
	struct SwiftUI {
		public typealias NSViewType = DSFDropFilesView

		/// Display properties for the view.
		public struct DisplayProperties {
			/// Is the border animated when a valid drop is available?
			let isAnimated: Bool
			/// Draw a dotted border around the outside of the view
			let isBordered: Bool
			/// The corner radius for the border
			let cornerRadius: CGFloat
			/// The border line width
			let lineWidth: CGFloat

			public init(
				isBordered: Bool = true,
				isAnimated: Bool = true,
				lineWidth: CGFloat = 2,
				cornerRadius: CGFloat = 4) {
				self.isBordered = isBordered
				self.isAnimated = isAnimated
				self.cornerRadius = cornerRadius
				self.lineWidth = lineWidth
			}
		}

		// MARK: Types

		/// User has dragged files into the view and require drop validation. Return the drag operation supported for the dragged files,
		/// or [] to disallow the drag.
		public typealias ValidateFuncType = (([URL]) -> NSDragOperation)

		/// Files dropped callback block. Return true if the block has successfully handled the drop, false otherwise.
		public typealias DropFuncType = (([URL]) -> Bool)

		/// Select files callback type
		public typealias SelectFuncType = (() -> Void)

		// MARK: - Properties

		/// The display properties for the view
		public let displayProperties: DisplayProperties

		/// Enable or disable the control
		public let isEnabled: Bool

		/// Allow dropping multiple files
		public let allowsMultipleDrop: Bool

		/// The icon for the control.  If nil, no icon is displayed
		public let icon: NSImage?

		/// The label to use for the icon.  If empty, label is not displayed
		public let iconLabel: String

		/// The font to use for the icon label.
		public let iconLabelFont: NSFont

		/// The label for the 'select files' button.  If empty, no select files button is displayed
		public let selectFilesLabel: String

		/// If true, the select files button is displayed as a hyperlink style. If false, displays as a regular button.
		public let selectFilesButtonIsLink: Bool

		// MARK: - Callbacks

		/// Called when the user drags some files into the view.
		public let validateFiles: ValidateFuncType?

		/// Called when the user drops files on the view
		public let dropFiles: DropFuncType?

		/// Called when the user clicks the 'select files' button
		public let selectFiles: SelectFuncType?

		/// Initializer
		///
		/// Needs to be provided as (by default) a default initializer is marked as internal
		public init(
			displayProperties: DisplayProperties = DisplayProperties(),
			isEnabled: Bool = true,
			allowsMultipleDrop: Bool = true,
			icon: NSImage? = nil,
			iconLabel: String = "",
			iconLabelFont: NSFont = .systemFont(ofSize: 16, weight: .bold),
			selectFilesLabel: String = "",
			selectFilesButtonIsLink: Bool = true,
			validateFiles: ValidateFuncType? = nil,
			dropFiles: DropFuncType? = nil,
			selectFiles: SelectFuncType? = nil
		) {
			self.displayProperties = displayProperties
			self.isEnabled = isEnabled
			self.allowsMultipleDrop = allowsMultipleDrop
			if let i = icon {
				self.icon = i
			}
			else {
				self.icon = DSFDropFilesView.StaticImage
			}
			self.iconLabel = iconLabel
			self.iconLabelFont = iconLabelFont
			self.selectFilesLabel = selectFilesLabel
			self.selectFilesButtonIsLink = selectFilesButtonIsLink
			self.validateFiles = validateFiles
			self.dropFiles = dropFiles
			self.selectFiles = selectFiles
		}
	}
}

// MARK: - Coordinator

/// Convenience function for optionally updating a value
/// - Parameters:
///   - result: The property to optionally update if 'val' is not equal to its value
///   - val: The value to check against
@inlinable internal func UpdateIfNotEqual<T>(_ result: inout T, _ val: T) where T: Equatable {
	if result != val {
		result = val
	}
}

@available(macOS 10.15, *)
extension DSFDropFilesView.SwiftUI: NSViewRepresentable {
	public func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}

	public func makeNSView(context: Context) -> DSFDropFilesView {
		let view = DSFDropFilesView(frame: .zero)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.dropDelegate = context.coordinator
		return view
	}

	public func updateNSView(_ nsView: DSFDropFilesView, context _: Context) {
		if self.icon !== nsView.icon {
			nsView.icon = self.icon
			nsView.showIcon = (nsView.icon == nil)
		}

		UpdateIfNotEqual(&nsView.isEnabled, self.isEnabled)
		UpdateIfNotEqual(&nsView.label, self.iconLabel)
		UpdateIfNotEqual(&nsView.selectFilesButtonLabel, self.selectFilesLabel)
		UpdateIfNotEqual(&nsView.allowsMultipleDrop, self.allowsMultipleDrop)
		UpdateIfNotEqual(&nsView.selectFilesButtonIsLink, self.selectFilesButtonIsLink)

		UpdateIfNotEqual(&nsView.isBordered, self.displayProperties.isBordered)
		UpdateIfNotEqual(&nsView.isAnimated, self.displayProperties.isAnimated)
		UpdateIfNotEqual(&nsView.lineWidth, self.displayProperties.lineWidth)
		UpdateIfNotEqual(&nsView.cornerRadius, self.displayProperties.cornerRadius)

		nsView.setLabelFont(self.iconLabelFont)
	}
}

// MARK: - Delegate handling

@available(macOS 10.15, *)
public extension DSFDropFilesView.SwiftUI {
	class Coordinator: NSObject, DSFDropFilesViewProtocol {
		let parent: DSFDropFilesView.SwiftUI
		init(_ dropView: DSFDropFilesView.SwiftUI) {
			self.parent = dropView
		}

		public func dropFilesView(_: DSFDropFilesView, validateFiles: [URL]) -> NSDragOperation {
			return self.parent.validateFiles?(validateFiles) ?? []
		}

		public func dropFilesView(_: DSFDropFilesView, didDropFiles files: [URL]) -> Bool {
			return self.parent.dropFiles?(files) ?? false
		}

		public func dropFilesViewWantsSelectFiles(_: DSFDropFilesView) {
			self.parent.selectFiles?()
		}
	}
}

#endif
