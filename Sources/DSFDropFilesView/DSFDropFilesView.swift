//
//  DSFDropFilesView.swift
//
//  Created by Darren Ford on 27/10/20.
//  Copyright © 2020 Darren Ford. All rights reserved.
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

import Cocoa

private extension NSNotification.Name {
	static let ThemeChangedNotification = NSNotification.Name("AppleInterfaceThemeChangedNotification")
}

/// A view that support dropping files
@IBDesignable
@objc public class DSFDropFilesView: NSView {

	// MARK: - Public accessors

	/// Enable or disable the control
	@IBInspectable dynamic public var isEnabled: Bool = true {
		didSet {
			self.selectButton.isEnabled = self.isEnabled
		}
	}

	/// The drop delegate.
	@IBOutlet public var dropDelegate: DSFDropFilesViewProtocol? {
		didSet {
			self.syncTitle()
		}
	}

	/// Do we support dropping multiple files at once?
	@IBInspectable var allowsMultipleSelect: Bool = true {
		didSet {
			self.syncTitle()
		}
	}

	/// The label for the 'select files...' button.  If empty, the button is not displayed.
	@IBInspectable var selectFilesButtonLabel: String = "" {
		didSet {
			self.syncTitle()
		}
	}

	/// If the select files button is shown, do we display it as a hyperlink or a regular button?
	@IBInspectable var selectFilesButtonIsLink: Bool = true {
		didSet {
			self.syncTitle()
		}
	}

	/// Should the drop target display an icon.
	@IBInspectable var showIcon: Bool = true {
		didSet {
			self.syncTitle()
		}
	}

	/// The image to be displayed.
	@IBInspectable var icon: NSImage? = DSFDropFilesView.StaticImage {
		didSet {
			self.imageView.image = self.icon
			self.syncImage()
		}
	}

	/// Display a informational label. If empty, the label is hidden.
	@IBInspectable var label: String = "" {
		didSet {
			self.syncTitle()
		}
	}

	/// Width of the border line around the control
	@IBInspectable var lineWidth: CGFloat = 2 {
		didSet {
			self.outerBoundary.lineWidth = self.lineWidth
		}
	}

	/// The corner radius for the border
	@IBInspectable var cornerWidth: CGFloat = 4
	var borderInset: CGFloat {
		return self.cornerWidth / 2.0
	}

	/// Should we animate the border when we can drop?
	@IBInspectable var animated: Bool = true

	// MARK: - Initialization

	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		self.configureControl()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.configureControl()
	}

	// MARK: - Private definitions

	private let displaySettings = DSFAccessibility.Display.shared
	private let outerBoundary = CAShapeLayer()

	private lazy var containerStack: NSStackView = {
		let s = NSStackView()
		s.translatesAutoresizingMaskIntoConstraints = false
		s.wantsLayer = true
		s.edgeInsets = NSEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)

		s.orientation = .vertical
		s.spacing = 4
		s.alignment = .centerX
		s.setContentHuggingPriority(NSLayoutConstraint.Priority(50), for: .horizontal)
		s.setContentHuggingPriority(NSLayoutConstraint.Priority(50), for: .vertical)

		s.setHuggingPriority(NSLayoutConstraint.Priority(50), for: .horizontal)
		s.setHuggingPriority(NSLayoutConstraint.Priority(50), for: .vertical)

		s.setContentCompressionResistancePriority(.required, for: .horizontal)
		s.setContentCompressionResistancePriority(.required, for: .vertical)

		s.addArrangedSubview(self.imageView)
		s.addArrangedSubview(self.imageLabel)
		s.addArrangedSubview(self.buttonSpacerView)
		s.addArrangedSubview(self.selectButton)

		return s
	}()

	private lazy var buttonSpacerView: NSView = {
		let sep = NSView(frame: .zero)
		sep.translatesAutoresizingMaskIntoConstraints = false
		sep.addConstraint(NSLayoutConstraint(item: sep, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 4))
		sep.addConstraint(NSLayoutConstraint(item: sep, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 8))
		return sep
	}()

	private lazy var imageView: NSImageView = {
		let i = NSImageView()
		i.translatesAutoresizingMaskIntoConstraints = false
		i.wantsLayer = true
		i.imageScaling = .scaleProportionallyDown
		i.image = self.icon

		i.isEditable = false
		i.unregisterDraggedTypes()

		i.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		i.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

		return i
	}()

	private lazy var imageLabel: NSTextField = {
		let t = NSTextField()
		t.translatesAutoresizingMaskIntoConstraints = false
		t.wantsLayer = true
		t.drawsBackground = false
		t.isBezeled = false
		t.font = NSFont.systemFont(ofSize: 16, weight: .bold)
		t.textColor = NSColor.tertiaryLabelColor
		t.stringValue = self.label
		t.alignment = .center
		t.isEditable = false
		t.isSelectable = false
		t.lineBreakMode = .byWordWrapping

		t.setContentHuggingPriority(.defaultLow, for: .horizontal)
		t.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

		return t
	}()

	private lazy var selectButton: DSFHandButton = {
		let button = DSFHandButton()
		button.wantsLayer = true
		button.translatesAutoresizingMaskIntoConstraints = false
		button.target = self
		button.action = #selector(self.selectFiles(_:))
		button.bezelStyle = .rounded
		button.isBordered = false
		button.controlSize = .regular
		button.isEnabled = true
		return button
	}()
}

// MARK: - Action callbacks

extension DSFDropFilesView {
	@objc func selectFiles(_: Any) {
		if let userSelectedFiles = self.dropDelegate?.dropFilesViewWantsSelectFiles {
			userSelectedFiles(self)
		}
	}

	@objc func themeChange(_: Notification) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			self.outerBoundary.strokeColor = self.backgroundStrokeColor()
		}
	}
}

// MARK: - UI Layout

extension DSFDropFilesView {
	override public func prepareForInterfaceBuilder() {
		self.configureControl()
	}

	override public func layout() {
		super.layout()
		self.outerBoundary.path = CGPath(
			roundedRect: self.bounds.insetBy(dx: self.borderInset, dy: self.borderInset),
			cornerWidth: self.cornerWidth,
			cornerHeight: self.cornerWidth, transform: nil
		)
	}

	private func syncImage() {
		let template = self.icon?.isTemplate ?? false
		self.imageView.alphaValue = template ? 0.4 : 1.0
	}

	private func syncTitle() {

		let buttonTitle = self.selectFilesButtonLabel
		if self.selectFilesButtonIsLink {
			let att = NSAttributedString(
				string: buttonTitle,
				attributes: [
					NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
					NSAttributedString.Key.foregroundColor: NSColor.linkColor,
				]
			)
			self.selectButton.isBordered = false
			self.selectButton.attributedTitle = att
			self.selectButton.wantsHandCursor = true
		}
		else {
			self.selectButton.isBordered = true
			self.selectButton.title = buttonTitle
			self.selectButton.wantsHandCursor = false
		}

		self.imageView.image = self.icon
		self.syncImage()
		self.imageView.isHidden = !self.showIcon

		self.imageLabel.stringValue = self.label

		// Hide the label if the label text is empty
		self.imageLabel.isHidden = self.label.isEmpty

		// Hide the select files button if no text has been set
		let hideSelectFilesButton = self.selectFilesButtonLabel.isEmpty
		self.buttonSpacerView.isHidden = hideSelectFilesButton
		self.selectButton.isHidden = hideSelectFilesButton

	}

	private func configureControl() {
		self.wantsLayer = true

		if #available(OSX 10.13, *) {
			self.registerForDraggedTypes([.fileURL])
		}
		else {
			let furl = NSPasteboard.PasteboardType(kUTTypeFileURL as String)
			self.registerForDraggedTypes([furl])
		}

		self.outerBoundary.fillColor = self.backgroundColor()
		self.outerBoundary.strokeColor = self.backgroundStrokeColor()
		self.outerBoundary.lineWidth = self.lineWidth

		self.outerBoundary.lineDashPattern = [4, 4]
		self.outerBoundary.lineDashPhase = 0

		self.layer!.addSublayer(self.outerBoundary)

		let stack = self.containerStack
		self.addSubview(stack)

		self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(8)-[but]-(8)-|", options: .alignAllCenterY, metrics: nil, views: ["but": stack]))
		self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=8)-[but]-(>=8)-|", options: .alignAllCenterX, metrics: nil, views: ["but": stack]))

		self.addConstraint(NSLayoutConstraint(item: stack, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
		self.addConstraint(NSLayoutConstraint(item: stack, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))

		DistributedNotificationCenter.default().addObserver(
			self,
			selector: #selector(self.themeChange),
			name: NSNotification.Name.ThemeChangedNotification,
			object: nil
		)

		self.syncTitle()
	}
}

// MARK: - Drag and drop

public extension DSFDropFilesView {
	private func filesOnPasteboard(for sender: NSDraggingInfo) -> [URL]? {
		let pb = sender.draggingPasteboard
		guard let objs = pb.readObjects(forClasses: [NSURL.self], options: nil) as? [NSURL] else {
			return nil
		}

		let urls = objs.compactMap { $0 as URL }
		return urls.count == 0 ? nil : urls
	}

	// Called when the user has dropped a file

	override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
		if self.isEnabled,
		   let delegate = self.dropDelegate,
		   let files = self.filesOnPasteboard(for: sender)
		{
			return delegate.dropFilesView(self, validateFiles: files) != []
		}
		return false
	}

	// When the user has dragged INTO the view

	override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
		var dragOperation: NSDragOperation = []

		// If there are no files on the pasteboard then do nothing
		guard let files = self.filesOnPasteboard(for: sender) else {
			return []
		}

		// If we are in single select and there are multiple files then don't allow drop
		if !self.allowsMultipleSelect, files.count != 1 {
			return []
		}

		if let delegate = self.dropDelegate {
			dragOperation = delegate.dropFilesView(self, validateFiles: files)
		}

		if dragOperation == [] {
			self.outerBoundary.strokeColor = self.backgroundStrokeColor()
			self.outerBoundary.fillColor = self.backgroundColor()
		}
		else {
			self.outerBoundary.strokeColor = self.backgroundActiveStrokeColor()
			self.outerBoundary.fillColor = self.backgroundActiveColor()

			self.startAnimation()
		}

		return dragOperation
	}

	// When the user has dragged OUT of the view or drag is cancelled

	override func draggingExited(_: NSDraggingInfo?) {
		self.outerBoundary.strokeColor = self.backgroundStrokeColor()
		self.outerBoundary.fillColor = self.backgroundColor()
		self.stopAnimation()
	}

	// Perform the drag operation

	override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
		self.stopAnimation()

		self.outerBoundary.strokeColor = self.backgroundStrokeColor()
		self.outerBoundary.fillColor = self.backgroundColor()

		if let delegate = self.dropDelegate,
		   let files = self.filesOnPasteboard(for: sender)
		{
			return delegate.dropFilesView(self, didDropFiles: files)
		}

		return false
	}
}

// MARK: - Colors

extension DSFDropFilesView {
	func backgroundColor() -> CGColor {
		return NSColor(calibratedWhite: 0, alpha: 0.05).cgColor
	}

	func backgroundStrokeColor() -> CGColor {
		var color: CGColor!
		UsingEffectiveAppearance(of: self) {
			color = NSColor.tertiaryLabelColor.cgColor
		}
		return color
	}

	func backgroundActiveColor() -> CGColor {
		var color: CGColor!
		UsingEffectiveAppearance(of: self) {
			color = NSColor.quaternaryLabelColor.cgColor
		}
		return color
	}

	func backgroundActiveStrokeColor() -> CGColor {
		var color: CGColor!
		UsingEffectiveAppearance(of: self) {
			color = NSColor.secondaryLabelColor.cgColor
		}
		return color
	}
}

// MARK: - Animation

extension DSFDropFilesView {
	func startAnimation() {
		if !self.animated || self.displaySettings.reduceMotion {
			return
		}

		let lineDashPhaseAnimation = CABasicAnimation(keyPath: "lineDashPhase")
		lineDashPhaseAnimation.byValue = 8.0
		lineDashPhaseAnimation.duration = 0.75
		lineDashPhaseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
		lineDashPhaseAnimation.repeatCount = .greatestFiniteMagnitude

		self.outerBoundary.add(lineDashPhaseAnimation, forKey: "lineDashPhaseAnimation")
	}

	func stopAnimation() {
		self.outerBoundary.removeAllAnimations()
	}
}

#endif
