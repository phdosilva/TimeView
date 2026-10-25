import SwiftUI
import AppKit

@main
struct TimeViewApp: App {
    @State private var clock = Clock()
    @State private var agenda = CalendarAgenda()
    
    #if DEBUG
    @State private var isSimulating = false
    @State private var simulatedMinute = 0.0
    private var minute: Int { isSimulating ? Int(simulatedMinute) : clock.minuteOfDay }
    #else
    private var minute: Int { clock.minuteOfDay }
    #endif
    
    var body: some Scene {
        MenuBarExtra {
            VStack(alignment: .leading, spacing: 12) {
                Text(String(format: "%02d:%02d", minute / 60, minute % 60))
                #if DEBUG
                Toggle("Simular horário", isOn: $isSimulating)
                if isSimulating {Slider(value: $simulatedMinute, in: 0...1439, step: 1) }
                #endif
                Divider()
                Button("Quit TimeView") {
                    NSApplication.shared.terminate(nil)
                }
                .buttonStyle(.plain)
                .keyboardShortcut("q")
            }
            .padding()
        } label: {
            Image(nsImage: menuBarImage(MenuBarLabel(minute: minute, events: agenda.events)))
        }
        .menuBarExtraStyle(.window)
    }
}
