import SwiftUI
import AppKit

@main
struct TimeViewApp: App {
    @State private var simulatedMinute = 14.0 * 60 + 40
    @State private var agenda = CalendarAgenda()
    
    private var minute: Int { Int(simulatedMinute) }

    var body: some Scene {
        MenuBarExtra {
            VStack(alignment: .leading, spacing: 12) {
                Text(String(format: "%02d:%02d", minute / 60, minute % 60))
                Slider(value: $simulatedMinute, in: 0...1439, step: 1)
                Divider()
                Button("Quit TimeView") {
                    NSApplication.shared.terminate(nil)
                }
                .buttonStyle(.plain)
                .keyboardShortcut("q")
            }
            .padding()
        } label: {
            Image(nsImage: menuBarImage(NextEventRail(minute: minute, events: agenda.events)))
        }
        .menuBarExtraStyle(.window)
    }
}
