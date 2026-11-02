//
//  HourBars.swift
//  TimeView
//
//  Created by Pedro Henrique on 02/11/26.
//

import SwiftUI

struct HourBars: View {
    let minute: Int
    let start: Int
    let end: Int
    let events: [AgendaEvent]
    
    private let barWidth: CGFloat = 8
    private let barHeight: CGFloat = 18
    private let spacing: CGFloat = 2
    
    private var hours: [Int] { Array(stride(from: start, to: end, by: 60)) }
    
    var body: some View {
        Canvas { ctx, _ in
            for (index, hourStart) in hours.enumerated() {
                let hourEnd = hourStart + 60
                let x = CGFloat(index) * (barWidth + spacing)
                let shape = Path(roundedRect: CGRect(x: x, y: 0, width: barWidth, height: barHeight), cornerRadius: 2)
                ctx.fill(shape, with: .color(.primary.opacity(0.2)))
                
                let from = min(max(minute, hourStart), hourEnd)
                guard from < hourEnd else { continue }
                func y(_ t: Int) -> CGFloat { CGFloat(t - hourStart) / 60 * barHeight }
                
                ctx.drawLayer { layer in
                    layer.clip(to: shape)
                    layer.fill(Path(CGRect(x: x, y: y(from), width: barWidth, height: barHeight - y(from))), with: .color(.primary))
                    for event in events where event.end > from && event.start < hourEnd {
                        let top = y(max(event.start, from))
                        let bottom = y(min(event.end, hourEnd))
                        layer.fill(Path(CGRect(x: x, y: top, width: barWidth, height: bottom - top)), with: .color(event.color))
                    }
                }
            }
        }
        .frame(width: CGFloat(hours.count) * (barWidth + spacing) - spacing, height: barHeight)
    }
}
