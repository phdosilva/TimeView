//
//  NextEventRail.swift
//  TimeView
//
//  Created by Pedro Henrique on 25/10/26.
//

import SwiftUI

nonisolated struct AgendaEvent {
    let start: Int
    let end: Int
    let title: String
    let color: Color
}

struct NextEventRail: View {
    let minute: Int
    let events: [AgendaEvent]
    var span = 180
    
    var body: some View {
        Canvas { ctx, size in
            func x(_ t: Int) -> CGFloat { CGFloat(t - minute) / CGFloat(span) * size.width }
            func line(_ a: CGPoint, _ b: CGPoint) -> Path { Path { $0.move(to: a); $0.addLine(to: b) } }
            let mid = size.height / 2
            let dim = Color.primary.opacity(0.35)
            
            ctx.stroke(line(.init(x: 0, y: mid), .init(x: size.width, y: mid)), with: .color(dim), lineWidth: 1.5)
            
            var hour = (minute / 60 + 1) * 60
            while hour < minute + span {
                let hx = x(hour)
                ctx.stroke(line(.init(x: hx, y:0), .init(x: hx, y: 3)), with: .color(dim), lineWidth: 1.5)
                ctx.stroke(line(.init(x: hx, y: size.height - 3), .init(x: hx, y: size.height)), with: .color(dim), lineWidth: 1.5)
                hour += 60
            }
            
            for event in events where event.end > minute && event.start < minute + span {
                let a = x(max(event.start, minute))
                let b = min(size.width, x(event.end))
                let rect = CGRect(x: a, y: 1, width: max(2.5, b - a), height: size.height - 2)
                ctx.fill(Path(roundedRect: rect, cornerRadius: 2), with: .color(.primary))
            }
            
            let inEvent = events.contains { $0.start <= minute && minute < $0.end }
            if !inEvent, let next = events.first(where: { $0.start > minute }) {
                let end = max(1, min(size.width, x(next.start)) - 2)
                ctx.stroke(line(.init(x: 1, y: mid), .init(x: end, y: mid)), with: .color(.primary), style: StrokeStyle(lineWidth: 2.5, lineCap: .round))
            }
            
            ctx.stroke(line(.init(x: 0.75, y: 0), .init(x: 0.75, y: size.height)), with: .color(.primary), lineWidth: 1.5)
        }
        .frame(width: 80, height: 12)
    }
}
