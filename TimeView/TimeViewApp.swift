import SwiftUI
import AppKit

@main
struct TimeViewApp: App {
    @State private var clock = Clock()
    @State private var simulated = 0.6

    var body: some Scene {
        MenuBarExtra {
            VStack(alignment: .leading, spacing: 12) {
                Text("Restante: \(Int(simulated * 100))%")
                Slider(value: $simulated, in: 0...1)
                Divider()
                Button("Quit TimeView") {
                    NSApplication.shared.terminate(nil)
                }
                .buttonStyle(.plain)
                .keyboardShortcut("q")
            }
            .padding()
        } label: {
//            Text(clock.now, format: .dateTime.weekday(.abbreviated).day().month(.abbreviated).hour().minute())
            Image(nsImage: HalfRingQuarters.menuBarImage(remaining: simulated))
        }
        .menuBarExtraStyle(.window)
    }
}
