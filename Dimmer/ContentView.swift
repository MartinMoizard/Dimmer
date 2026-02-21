import SwiftUI

struct ContentView: View {
    @AppStorage("dimLevel") private var dimLevel: Double = 0
    private let overlayManager = OverlayManager.shared

    var body: some View {
        VStack(spacing: 16) {
            Text("Dimmer")
                .font(.headline)

            HStack(spacing: 12) {
                Image(systemName: "sun.max")
                    .foregroundStyle(.secondary)

                Slider(value: $dimLevel, in: 0...0.9)
                    .onChange(of: dimLevel) {
                        overlayManager.opacity = dimLevel
                    }

                Image(systemName: "moon.fill")
                    .foregroundStyle(.secondary)
            }

            Text("\(Int(dimLevel * 100))% dimming")
                .font(.caption)
                .foregroundStyle(.secondary)

            Divider()

            Button("Quit") {
                overlayManager.removeOverlays()
                NSApplication.shared.terminate(nil)
            }
        }
        .padding()
        .frame(width: 220)
        .onAppear {
            overlayManager.opacity = dimLevel
        }
    }
}
