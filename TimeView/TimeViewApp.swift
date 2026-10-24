import SwiftUI
import AppKit

@main struct TimeViewApp: App {
    var body: some Scene {
        MenuBarExtra("TimeView", systemImage: "aqi.low") {
            Button("Sair") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q")
        }
    }
}
