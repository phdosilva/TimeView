//
//  MenuBarImage.swift
//  TimeView
//
//  Created by Pedro Henrique on 24/10/26.
//

import SwiftUI
//
//func menuBarImage(_ content: some View) -> NSImage {
//    let renderer = ImageRenderer(content: content)
//    renderer.scale = 2
//    let image = renderer.nsImage ?? NSImage()
//    image.isTemplate = true
//    return image
//}

func menuBarImage(_ content: some View) -> NSImage {
    let size = ImageRenderer(content: content).nsImage?.size ?? .zero
    return NSImage(size: size, flipped: false) { rect in
        MainActor.assumeIsolated {
            let isDark = NSAppearance.currentDrawing().bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
            let renderer = ImageRenderer(content: content.environment(\.colorScheme, isDark ? .dark : .light))
            renderer.scale = 2
            renderer.nsImage?.draw(in: rect)
        }
        return true
    }
}
