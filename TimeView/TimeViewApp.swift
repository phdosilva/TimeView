import SwiftUI
import AppKit

@main
struct TimeViewApp: App {
    @State private var simulated = 0.6
    @State private var symbol = "clock.circle"
    
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
            Image(nsImage: menuBarImage(
                Image(systemName: symbol, variableValue: simulated)
                    .symbolVariableValueMode(.draw   )
                    .symbolRenderingMode(.palette)
                    .symbolColorRenderingMode(.gradient)
                    .foregroundStyle(.primary, Color.accentColor)
                    .font(.system(size: 17, weight: .bold)))
            )
        }
        .menuBarExtraStyle(.window)
    }
}
