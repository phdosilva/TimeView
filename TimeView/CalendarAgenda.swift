//
//  CalendarAgenda.swift
//  TimeView
//
//  Created by Pedro Henrique on 25/10/26.
//

import EventKit
import SwiftUI

nonisolated struct AgendaEvent {
    let start: Int
    let end: Int
    let title: String
    let color: Color
}

@Observable
final class CalendarAgenda {
    private(set) var events: [AgendaEvent] = []
    private let store = EKEventStore()
    
    init() {
        Task { await load() }
        
        NotificationCenter.default.addObserver(forName: .EKEventStoreChanged, object: store, queue: .main) { [weak self] _ in
            Task { await self?.load() }
        }
        
        NotificationCenter.default.addObserver(forName: .NSCalendarDayChanged, object: nil, queue: .main) { [weak self] _ in
            Task { await self?.load() }
        }
    }
    
    private func load() async {
        guard (try? await store.requestFullAccessToEvents()) == true else { return }
        let calendar = Calendar.current
        let dayStart = calendar.startOfDay(for: .now)
        let dayEnd = calendar.date(byAdding: .day, value: 1, to: dayStart)!
        let predicate = store.predicateForEvents(withStart: dayStart, end: dayEnd, calendars: nil)
        
        func minute(_ date: Date) -> Int { Int(min(date, dayEnd).timeIntervalSince(dayStart) / 60) }
        
        events = store.events(matching: predicate)
            .filter { !$0.isAllDay }
            .map { AgendaEvent(start: minute($0.startDate), end: minute($0.endDate), title: $0.title ?? "", color: Color(cgColor: $0.calendar.cgColor)) }
            .sorted { $0.start < $1.start }
    }
}

