//
//  Clock.swift
//  TimeView
//
//  Created by Pedro Henrique on 25/10/26.
//

import Foundation
import Observation

@Observable
final class Clock {
    private(set) var now = Date.now
    
    init() {
        Task { [weak self] in
            while true {
                let second = Calendar.current.component(.second, from: .now)
                try? await Task.sleep(for: .seconds(60 - second))
                guard let self else { return }
                self.now = .now
            }
        }
    }
    
    var minuteOfDay: Int {
        let time = Calendar.current.dateComponents([.hour, .minute], from: now)
        return time.hour! * 60 + time.minute!
    }
}
