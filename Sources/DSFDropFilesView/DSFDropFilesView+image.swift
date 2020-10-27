//
//  DSFDropFilesView+image.swift
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

import AppKit

internal extension DSFDropFilesView {

	static let StaticImage: NSImage = {
		let im = NSImage.init(size: NSSize(width: 64, height: 64), flipped: false) { rect in
			let bezier = DSFDropFilesView.iconBezier()
			NSColor.black.set()
			bezier.fill()
			return true
		}
		im.isTemplate = true
		return im
	}()

	static func iconBezier() -> NSBezierPath {
		//// Text Drawing
		let textPath = NSBezierPath()
		textPath.move(to: NSPoint(x: 33.2, y: 32.68))
		textPath.curve(to: NSPoint(x: 32.89, y: 33.4), controlPoint1: NSPoint(x: 33.2, y: 32.95), controlPoint2: NSPoint(x: 33.09, y: 33.19))
		textPath.curve(to: NSPoint(x: 32.14, y: 33.71), controlPoint1: NSPoint(x: 32.68, y: 33.6), controlPoint2: NSPoint(x: 32.44, y: 33.71))
		textPath.curve(to: NSPoint(x: 31.4, y: 33.4), controlPoint1: NSPoint(x: 31.85, y: 33.71), controlPoint2: NSPoint(x: 31.6, y: 33.6))
		textPath.curve(to: NSPoint(x: 31.09, y: 32.68), controlPoint1: NSPoint(x: 31.19, y: 33.19), controlPoint2: NSPoint(x: 31.09, y: 32.95))
		textPath.line(to: NSPoint(x: 31.09, y: 17.86))
		textPath.line(to: NSPoint(x: 31.18, y: 11.76))
		textPath.line(to: NSPoint(x: 25.61, y: 17.42))
		textPath.line(to: NSPoint(x: 23.18, y: 19.91))
		textPath.curve(to: NSPoint(x: 22.86, y: 20.11), controlPoint1: NSPoint(x: 23.1, y: 19.98), controlPoint2: NSPoint(x: 22.99, y: 20.05))
		textPath.curve(to: NSPoint(x: 22.45, y: 20.2), controlPoint1: NSPoint(x: 22.72, y: 20.17), controlPoint2: NSPoint(x: 22.58, y: 20.2))
		textPath.curve(to: NSPoint(x: 21.71, y: 19.91), controlPoint1: NSPoint(x: 22.15, y: 20.2), controlPoint2: NSPoint(x: 21.91, y: 20.1))
		textPath.curve(to: NSPoint(x: 21.42, y: 19.17), controlPoint1: NSPoint(x: 21.52, y: 19.71), controlPoint2: NSPoint(x: 21.42, y: 19.47))
		textPath.curve(to: NSPoint(x: 21.61, y: 18.56), controlPoint1: NSPoint(x: 21.42, y: 18.9), controlPoint2: NSPoint(x: 21.48, y: 18.7))
		textPath.curve(to: NSPoint(x: 22.01, y: 18.12), controlPoint1: NSPoint(x: 21.74, y: 18.42), controlPoint2: NSPoint(x: 21.87, y: 18.28))
		textPath.line(to: NSPoint(x: 31.35, y: 8.98))
		textPath.curve(to: NSPoint(x: 31.73, y: 8.69), controlPoint1: NSPoint(x: 31.47, y: 8.84), controlPoint2: NSPoint(x: 31.6, y: 8.74))
		textPath.curve(to: NSPoint(x: 32.14, y: 8.6), controlPoint1: NSPoint(x: 31.87, y: 8.63), controlPoint2: NSPoint(x: 32.01, y: 8.6))
		textPath.curve(to: NSPoint(x: 32.54, y: 8.69), controlPoint1: NSPoint(x: 32.28, y: 8.6), controlPoint2: NSPoint(x: 32.41, y: 8.63))
		textPath.curve(to: NSPoint(x: 32.93, y: 8.98), controlPoint1: NSPoint(x: 32.67, y: 8.74), controlPoint2: NSPoint(x: 32.8, y: 8.84))
		textPath.line(to: NSPoint(x: 42.25, y: 18.12))
		textPath.curve(to: NSPoint(x: 42.67, y: 18.56), controlPoint1: NSPoint(x: 42.41, y: 18.28), controlPoint2: NSPoint(x: 42.55, y: 18.42))
		textPath.curve(to: NSPoint(x: 42.87, y: 19.17), controlPoint1: NSPoint(x: 42.8, y: 18.7), controlPoint2: NSPoint(x: 42.87, y: 18.9))
		textPath.curve(to: NSPoint(x: 42.56, y: 19.91), controlPoint1: NSPoint(x: 42.87, y: 19.47), controlPoint2: NSPoint(x: 42.76, y: 19.71))
		textPath.curve(to: NSPoint(x: 41.84, y: 20.2), controlPoint1: NSPoint(x: 42.35, y: 20.1), controlPoint2: NSPoint(x: 42.11, y: 20.2))
		textPath.curve(to: NSPoint(x: 41.42, y: 20.11), controlPoint1: NSPoint(x: 41.7, y: 20.2), controlPoint2: NSPoint(x: 41.56, y: 20.17))
		textPath.curve(to: NSPoint(x: 41.08, y: 19.91), controlPoint1: NSPoint(x: 41.27, y: 20.05), controlPoint2: NSPoint(x: 41.16, y: 19.98))
		textPath.line(to: NSPoint(x: 38.65, y: 17.42))
		textPath.line(to: NSPoint(x: 33.11, y: 11.76))
		textPath.line(to: NSPoint(x: 33.2, y: 17.86))
		textPath.line(to: NSPoint(x: 33.2, y: 32.68))
		textPath.close()
		textPath.move(to: NSPoint(x: 16.35, y: 1.13))
		textPath.line(to: NSPoint(x: 47.93, y: 1.13))
		textPath.curve(to: NSPoint(x: 53.79, y: 3.13), controlPoint1: NSPoint(x: 50.51, y: 1.13), controlPoint2: NSPoint(x: 52.46, y: 1.8))
		textPath.curve(to: NSPoint(x: 55.79, y: 9.04), controlPoint1: NSPoint(x: 55.12, y: 4.47), controlPoint2: NSPoint(x: 55.79, y: 6.44))
		textPath.line(to: NSPoint(x: 55.79, y: 37.69))
		textPath.curve(to: NSPoint(x: 55.64, y: 39.68), controlPoint1: NSPoint(x: 55.79, y: 38.47), controlPoint2: NSPoint(x: 55.74, y: 39.13))
		textPath.curve(to: NSPoint(x: 55.1, y: 41.18), controlPoint1: NSPoint(x: 55.54, y: 40.23), controlPoint2: NSPoint(x: 55.36, y: 40.73))
		textPath.curve(to: NSPoint(x: 53.97, y: 42.55), controlPoint1: NSPoint(x: 54.83, y: 41.63), controlPoint2: NSPoint(x: 54.46, y: 42.08))
		textPath.line(to: NSPoint(x: 35.37, y: 61.24))
		textPath.curve(to: NSPoint(x: 33.99, y: 62.34), controlPoint1: NSPoint(x: 34.9, y: 61.71), controlPoint2: NSPoint(x: 34.44, y: 62.08))
		textPath.curve(to: NSPoint(x: 32.51, y: 62.9), controlPoint1: NSPoint(x: 33.54, y: 62.61), controlPoint2: NSPoint(x: 33.05, y: 62.79))
		textPath.curve(to: NSPoint(x: 30.59, y: 63.06), controlPoint1: NSPoint(x: 31.97, y: 63.01), controlPoint2: NSPoint(x: 31.33, y: 63.06))
		textPath.line(to: NSPoint(x: 16.35, y: 63.06))
		textPath.curve(to: NSPoint(x: 10.49, y: 61.05), controlPoint1: NSPoint(x: 13.79, y: 63.06), controlPoint2: NSPoint(x: 11.84, y: 62.39))
		textPath.curve(to: NSPoint(x: 8.47, y: 55.18), controlPoint1: NSPoint(x: 9.14, y: 59.72), controlPoint2: NSPoint(x: 8.47, y: 57.76))
		textPath.line(to: NSPoint(x: 8.47, y: 9.04))
		textPath.curve(to: NSPoint(x: 10.46, y: 3.12), controlPoint1: NSPoint(x: 8.47, y: 6.42), controlPoint2: NSPoint(x: 9.13, y: 4.45))
		textPath.curve(to: NSPoint(x: 16.35, y: 1.13), controlPoint1: NSPoint(x: 11.79, y: 1.79), controlPoint2: NSPoint(x: 13.75, y: 1.13))
		textPath.close()
		textPath.move(to: NSPoint(x: 16.44, y: 3.29))
		textPath.curve(to: NSPoint(x: 12.1, y: 4.76), controlPoint1: NSPoint(x: 14.53, y: 3.29), controlPoint2: NSPoint(x: 13.08, y: 3.78))
		textPath.curve(to: NSPoint(x: 10.64, y: 9.1), controlPoint1: NSPoint(x: 11.13, y: 5.74), controlPoint2: NSPoint(x: 10.64, y: 7.18))
		textPath.line(to: NSPoint(x: 10.64, y: 55.09))
		textPath.curve(to: NSPoint(x: 12.1, y: 59.38), controlPoint1: NSPoint(x: 10.64, y: 56.95), controlPoint2: NSPoint(x: 11.13, y: 58.38))
		textPath.curve(to: NSPoint(x: 16.44, y: 60.89), controlPoint1: NSPoint(x: 13.08, y: 60.39), controlPoint2: NSPoint(x: 14.53, y: 60.89))
		textPath.line(to: NSPoint(x: 31.09, y: 60.89))
		textPath.line(to: NSPoint(x: 31.09, y: 42.44))
		textPath.curve(to: NSPoint(x: 32.14, y: 39.27), controlPoint1: NSPoint(x: 31.09, y: 40.99), controlPoint2: NSPoint(x: 31.44, y: 39.94))
		textPath.curve(to: NSPoint(x: 35.22, y: 38.28), controlPoint1: NSPoint(x: 32.85, y: 38.61), controlPoint2: NSPoint(x: 33.87, y: 38.28))
		textPath.line(to: NSPoint(x: 53.62, y: 38.28))
		textPath.line(to: NSPoint(x: 53.62, y: 9.1))
		textPath.curve(to: NSPoint(x: 52.15, y: 4.76), controlPoint1: NSPoint(x: 53.62, y: 7.18), controlPoint2: NSPoint(x: 53.13, y: 5.74))
		textPath.curve(to: NSPoint(x: 47.82, y: 3.29), controlPoint1: NSPoint(x: 51.18, y: 3.78), controlPoint2: NSPoint(x: 49.73, y: 3.29))
		textPath.line(to: NSPoint(x: 16.44, y: 3.29))
		textPath.close()
		textPath.move(to: NSPoint(x: 35.39, y: 40.38))
		textPath.curve(to: NSPoint(x: 33.68, y: 40.88), controlPoint1: NSPoint(x: 34.59, y: 40.38), controlPoint2: NSPoint(x: 34.02, y: 40.55))
		textPath.curve(to: NSPoint(x: 33.17, y: 42.61), controlPoint1: NSPoint(x: 33.34, y: 41.21), controlPoint2: NSPoint(x: 33.17, y: 41.79))
		textPath.line(to: NSPoint(x: 33.17, y: 60.39))
		textPath.line(to: NSPoint(x: 53.12, y: 40.38))
		textPath.line(to: NSPoint(x: 35.39, y: 40.38))
		textPath.close()
		return textPath
	}
}

#endif
