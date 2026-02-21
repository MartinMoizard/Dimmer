import SwiftUI

struct ContentView: View {
    @AppStorage("brightnessLevel") private var brightness: Double = 1.0
    private let overlayManager = OverlayManager.shared

    private var dimming: Double { 1.0 - brightness }

    var body: some View {
        VStack(spacing: 16) {
            Text("Dimmer")
                .font(.headline)

            HStack(spacing: 12) {
                Image(systemName: "moon.fill")
                    .foregroundStyle(.secondary)

                Slider(value: $brightness, in: 0.1...1.0)
                    .onChange(of: brightness) {
                        overlayManager.opacity = dimming
                    }

                Image(systemName: "sun.max")
                    .foregroundStyle(.secondary)
            }

            Button("Quit") {
                overlayManager.removeOverlays()
                NSApplication.shared.terminate(nil)
            }
        }
        .padding()
        .frame(width: 220)
        .onAppear {
            overlayManager.opacity = dimming
        }
    }
}
