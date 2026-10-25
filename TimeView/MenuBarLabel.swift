//
//  MenuBarLabel.swift
//  TimeView
//
//  Created by Pedro Henrique on 25/10/26.
//

import SwiftUI

struct MenuBarLabel: View {
    let minute: Int
    let events: [AgendaEvent]

    private var current: AgendaEvent? { events.first { $0.start <= minute && minute < $0.end } }
    private var next: AgendaEvent? { events.first { $0.start > minute } }

    private func shortDuration(_ minutes: Int) -> String {
        if minutes < 60 { return "\(minutes) min" }
        let rest = minutes % 60
        return rest == 0 ? "\(minutes / 60)h" : String(format: "%dh %02d", minutes / 60, rest)
    }
    
    var body: some View {
        HStack(spacing: 6) {
            if let event = current ?? next {
                VStack(alignment: .trailing, spacing: -1) {
                    Text(event.title)
                        .foregroundStyle(current == nil ? .secondary : .primary)
                    Text(shortDuration(current.map { $0.end - minute } ?? event.start - minute))
                        .foregroundStyle(.secondary)
                }
                .font(.system(size: 10, weight: .medium))
                .lineLimit(1)
                .frame(maxWidth: 70, alignment: .trailing)
            }
            NextEventRail(minute: minute, events: events)
        }
    }
}
