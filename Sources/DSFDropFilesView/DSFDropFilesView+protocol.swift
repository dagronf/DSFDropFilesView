//
//  DSFDropFilesView+protocol.swift
//
//  Copyright © 2024 Darren Ford. All rights reserved.
//
//  MIT license
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
//  documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial
//  portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
//  WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
//  OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
//  OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#if os(macOS)

import AppKit

/// Delegate protocol for a Drop Files View.
@objc public protocol DSFDropFilesViewProtocol: NSObjectProtocol {
	/// Callback to the owner that the user has clicked the 'Select Files...' button
	@objc optional func dropFilesViewWantsSelectFiles(_ sender: DSFDropFilesView)

	/// Ask the delegate to validate the urls that the user has dragged onto the control
	/// - Parameters:
	///   - sender: The drop files view that initiated the action
	///   - validateFiles: The urls to be validated
	/// - Returns the drag operation for the dragged files. Return [] to fail the drag
	func dropFilesView(_ sender: DSFDropFilesView, validateFiles: [URL]) -> NSDragOperation

	/// The files have been dropped on the view
	/// - Parameters:
	///   - sender: The drop files view that initiated the action
	///   - files: The urls that were dropped
	/// - Returns true if the drop action was successful
	func dropFilesView(_ sender: DSFDropFilesView, didDropFiles files: [URL]) -> Bool
}

#endif
