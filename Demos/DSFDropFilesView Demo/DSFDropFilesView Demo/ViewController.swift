//
//  ViewController.swift
//  DSFDropFilesView Demo
//
//  Created by Darren Ford on 27/10/20.
//

import Cocoa
import DSFDropFilesView

class ViewController: NSViewController {
	@IBOutlet var left: DSFDropFilesView!
	@IBOutlet weak var middle: DSFDropFilesView!
	@IBOutlet var right: DSFDropFilesView!

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
	}

	override var representedObject: Any? {
		didSet {
			// Update the view, if already loaded.
		}
	}
}

extension ViewController: DSFDropFilesViewProtocol {
	private func isFolder(_ url: URL) -> Bool {
		var r = ObjCBool(false)
		FileManager.default.fileExists(atPath: url.path, isDirectory: &r)
		return r.boolValue
	}

	func dropFilesViewWantsSelectFiles(_ sender: DSFDropFilesView) {
		guard sender === self.left else {
			return
		}

		let myOpen = NSOpenPanel()
		myOpen.allowsMultipleSelection = true
		myOpen.canChooseFiles = true
		myOpen.canChooseDirectories = true

		if let w = self.view.window {
			myOpen.beginSheetModal(for: w) { response in
				if response == NSApplication.ModalResponse.OK {
					Swift.print(myOpen.urls)
				}
			}
		}
	}

	func dropFilesView(_ sender: DSFDropFilesView, validateFiles: [URL]) -> NSDragOperation {
		if sender === self.left {
			let foundInvalidImage = validateFiles.first { (url) -> Bool in
				guard let im = NSImage(byReferencingFile: url.path) else {
					// Found an invalid image
					return true
				}
				return !im.isValid
			}

			if let _ = foundInvalidImage {
				return []
			}

			return .copy
		}
		else if sender === self.right {
			let c = validateFiles.filter { !self.isFolder($0) }.count
			return c > 0 ? [] : .copy
		}
		else if sender === self.middle {
			return .copy
		}
		return []
	}

	func dropFilesView(_: DSFDropFilesView, didDropFiles files: [URL]) -> Bool {
		Swift.print(files)
		return true
	}
}
