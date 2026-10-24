//
//  Clock.swift
//  TimeView
//
//  Created by Pedro Henrique on 24/10/26.
//

import Foundation
import Observation

@Observable
final class Clock {
    private(set) var now = Date()

    init() {
        Task { [weak self] in
            while !Task.isCancelled {
                let current = Date()
                let nextMinute = Calendar.current.nextDate(
                    after: current,
                    matching: DateComponents(second: 0),
                    matchingPolicy: .nextTime
                ) ?? current.addingTimeInterval(60)
                try? await Task.sleep(for: .seconds(nextMinute.timeIntervalSince(current)))
                self?.now = Date()
            }
        }
    }
}
