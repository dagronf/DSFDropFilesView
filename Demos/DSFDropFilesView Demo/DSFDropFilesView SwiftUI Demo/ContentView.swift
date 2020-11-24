//
//  ContentView.swift
//  DSFDropFilesView SwiftUI Demo
//
//  Created by Darren Ford on 23/11/20.
//

import SwiftUI

import DSFDropFilesView

struct ContentView: View {

	@State private var label = "Drop On Me!"
	@State private var dropEnabled = true

	private var displayProperties =
		DSFDropFilesView.SwiftUI.DisplayProperties(cornerRadius: 12)

	var body: some View {
		VStack {
			DSFDropFilesView.SwiftUI(
				displayProperties: self.displayProperties,
				isEnabled: self.dropEnabled,
				allowsMultipleDrop: true,
				iconLabel: self.label,
				selectFilesLabel: "Select Files…",
				selectFilesButtonIsLink: true,
				validateFiles: { urls in
					return .copy
				},
				dropFiles: { urls in
					Swift.print("\(urls)")
					return true
				},
				selectFiles: {
					Swift.print("User clicked select files")
				}
			)
			.padding(4)

			Button("Toggle settings") {
				self.dropEnabled.toggle()
				self.label = self.dropEnabled ? "Drop On Me!" : "You Can't Drop On Me!"
			}
			.padding(8)
		}
	}
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
