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
    let dayStart: Int
    let dayEnd: Int

    private var current: AgendaEvent? { events.first { $0.start <= minute && minute < $0.end } }
    private var next: AgendaEvent? { events.first { $0.start > minute } }
    private var remaining: Int? {
        current.map { $0.end - minute } ?? next.map { $0.start - minute }
    }

    private func shortDuration(_ minutes: Int) -> String {
        if minutes < 60 { return "\(minutes) min" }
        let rest = minutes % 60
        return rest == 0 ? "\(minutes / 60)h" : String(format: "%dh %02d", minutes / 60, rest)
    }
    
    var body: some View {
        if minute < dayStart {
            Image(systemName: "sun.max.fill")
                .font(.system(size: 14))
        } else if minute >= dayEnd {
            Image(systemName: "moon.fill")
                .font(.system(size: 14))
        } else {
            HStack(spacing: 6) {
                VStack(alignment: .trailing, spacing: -1) {
                    Text(current?.title ?? "Livre")
                    if let remaining {
                        Text(shortDuration(remaining))
                            .foregroundStyle(.secondary)
                    }
                }
                .font(.system(size: 10, weight: .medium))
                .lineLimit(1)
                .frame(maxWidth: 70, alignment: .trailing)
                HourBars(minute: minute, start: dayStart, end: dayEnd, events: events)
            }
        }
    }}
