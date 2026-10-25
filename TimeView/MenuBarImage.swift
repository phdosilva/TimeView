//
//  MenuBarImage.swift
//  TimeView
//
//  Created by Pedro Henrique on 24/10/26.
//

import SwiftUI
import AppKit

func menuBarImage(_ content: some View) -> NSImage {
    let isDark = NSApp.effectiveAppearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
    let renderer = ImageRenderer(content: content.environment(\.colorScheme, isDark ? .dark : .light))
    renderer.scale = 2
    return renderer.nsImage ?? NSImage()
}
