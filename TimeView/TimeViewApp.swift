import SwiftUI
import AppKit

@main
struct TimeViewApp: App {
    @State private var clock = Clock()
    @State private var agenda = CalendarAgenda()
    
    var body: some Scene {
        MenuBarExtra {
            VStack(alignment: .leading, spacing: 12) {
                Text(String(format: "%02d:%02d", clock.minuteOfDay / 60, clock.minuteOfDay % 60))
                Divider()
                Button("Quit TimeView") {
                    NSApplication.shared.terminate(nil)
                }
                .buttonStyle(.plain)
                .keyboardShortcut("q")
            }
            .padding()
        } label: {
            Image(nsImage: menuBarImage(NextEventRail(minute: clock.minuteOfDay, events: agenda.events)))
        }
        .menuBarExtraStyle(.window)
    }
}
