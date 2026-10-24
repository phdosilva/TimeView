import SwiftUI
import AppKit

@main
struct TimeViewApp: App {
    @State private var clock = Clock()
    
    var body: some Scene {
        MenuBarExtra {
            Button("Sair") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q")
        } label: {
            Text(clock.now, format: .dateTime.weekday(.abbreviated).day().month(.abbreviated).hour().minute())
        }
    }
}
