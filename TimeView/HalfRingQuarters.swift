//
//  HalfRingQuarters.swift
//  TimeView
//
//  Created by Pedro Henrique on 24/10/26.
//

import SwiftUI
import AppKit

struct HalfRingQuarters: View {
    var remaining: Double
    
    private let gap = 6.0
    private let lineWidth = 3.0
    
    var body: some View {
        ZStack {
            ForEach(0..<4, id: \.self) { i in
                let start = 180.0 + Double(i) * 45 + gap / 2
                let span = 45 - gap
                let fill = min(1, max(0, remaining * 4 - Double(i)))
            
                ArcSegment(start: .degrees(start), end: .degrees(start + span)).stroke(.primary.opacity(0.3), lineWidth: lineWidth)
                ArcSegment(start: .degrees(start + span * fill), end: .degrees(start + span)).stroke(.primary, lineWidth: lineWidth)
            }
        }
        .frame(width: 20, height: 10)
        .padding(lineWidth / 2)
    }
}

nonisolated private struct ArcSegment: Shape {
    var start: Angle
    var end: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.maxY),
            radius: min(rect.width / 2, rect.height),
            startAngle: start,
            endAngle: end,
            clockwise: false
        )
        return path
    }
}

extension HalfRingQuarters {
    static func menuBarImage(remaining: Double) -> NSImage {
        let renderer = ImageRenderer(content: HalfRingQuarters(remaining: remaining))
        renderer.scale = NSScreen.main?.backingScaleFactor ?? 2
        let image = renderer.nsImage ?? NSImage()
        image.isTemplate = true
        return image
    }
}

#Preview {
    HStack(spacing: 16) {
        ForEach([1.0, 0.8, 0.5, 0.2, 0.0], id: \.self) {
            HalfRingQuarters(remaining: $0)
        }
    }
    .padding()
}
