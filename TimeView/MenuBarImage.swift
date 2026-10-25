//
//  MenuBarImage.swift
//  TimeView
//
//  Created by Pedro Henrique on 24/10/26.
//

import SwiftUI

func menuBarImage(_ content: some View) -> NSImage {
    let renderer = ImageRenderer(content: content)
    renderer.scale = 2
    let image = renderer.nsImage ?? NSImage()
    image.isTemplate = true
    return image
}
