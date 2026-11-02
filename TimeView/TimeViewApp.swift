import SwiftUI
import AppKit

@main
struct TimeViewApp: App {
    @State private var clock = Clock()
    @State private var agenda = CalendarAgenda()
    @AppStorage("dayStartHour") private var dayStartHour = 8
    @AppStorage("dayEndHour") private var dayEndHour = 18
    
    #if DEBUG
    @State private var isSimulating = false
    @State private var simulatedMinute = 0.0
    private var minute: Int { isSimulating ? Int(simulatedMinute) : clock.minuteOfDay }
    
    private func shiftDebugTime(by delta: Int) {
        if !isSimulating {
            simulatedMinute = Double(clock.minuteOfDay)
            isSimulating = true
        }
        simulatedMinute += Double(delta)
    }
    #else
    private var minute: Int { clock.minuteOfDay }
    #endif
    
    var body: some Scene {
        MenuBarExtra {
            Section("Hoje") {
                let upcoming = agenda.events.filter { $0.end > minute }
                if upcoming.isEmpty {
                    Text("Nenhum evento restante")
                }
                ForEach(upcoming.indices, id: \.self) { index in
                    let event = upcoming[index]
                    Button(action: openCalendar) {
                        Text(event.title)
                        Text("\(clockTime(event.start)) – \(clockTime(event.end))")
                    }
                }
            }
            Button("Abrir Calendário", action: openCalendar)
            Menu("Horário do dia") {
                Picker("Início", selection: $dayStartHour) {
                    ForEach(5..<dayEndHour, id: \.self) { Text("\($0):00").tag($0) }
                }
                Picker("Fim", selection: $dayEndHour) {
                    ForEach((dayStartHour + 1)...23, id: \.self) { Text("\($0):00").tag($0) }
                }
            }
            Text("TimeView \(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "")")
            Divider()
            #if DEBUG
            Menu("Simular horário") {
                Button("Avançar 15 min") { shiftDebugTime(by: 15) }
                Button("Voltar 15 min") { shiftDebugTime(by: -15) }
                Divider()
                Button("Usar horário real") { isSimulating = false }
            }
            #endif
            Button("Sair do TimeView") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q")
        } label: {
            Image(nsImage: menuBarImage(MenuBarLabel(minute: minute, events: agenda.events, dayStart: dayStartHour * 60, dayEnd: dayEndHour * 60)))}
        .menuBarExtraStyle(.menu)
    }
    
    private func clockTime(_ minute: Int) -> String {
        String(format: "%02d:%02d", minute / 60, minute % 60)
    }

    private func openCalendar() {
        NSWorkspace.shared.open(URL(string: "ical://")!)
    }
}

