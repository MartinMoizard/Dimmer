import AppKit

@MainActor
final class OverlayManager {
    static let shared = OverlayManager()

    private var overlayWindows: [NSWindow] = []

    private init() {
        NotificationCenter.default.addObserver(
            forName: NSApplication.didChangeScreenParametersNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            MainActor.assumeIsolated {
                self?.recreateOverlays()
            }
        }
    }

    var opacity: Double = 0 {
        didSet {
            if overlayWindows.isEmpty && opacity > 0 {
                createOverlays()
            }
            for window in overlayWindows {
                window.backgroundColor = NSColor.black.withAlphaComponent(opacity)
            }
            if opacity <= 0 {
                removeOverlays()
            }
        }
    }

    private func createOverlays() {
        for screen in NSScreen.screens {
            let window = NSWindow(
                contentRect: screen.frame,
                styleMask: .borderless,
                backing: .buffered,
                defer: false
            )
            window.level = .screenSaver
            window.collectionBehavior = [.canJoinAllSpaces, .stationary]
            window.backgroundColor = NSColor.black.withAlphaComponent(opacity)
            window.isOpaque = false
            window.hasShadow = false
            window.ignoresMouseEvents = true
            window.orderFrontRegardless()
            overlayWindows.append(window)
        }
    }

    private func recreateOverlays() {
        removeOverlays()
        if opacity > 0 {
            createOverlays()
        }
    }

    func removeOverlays() {
        for window in overlayWindows {
            window.orderOut(nil)
        }
        overlayWindows.removeAll()
    }
}
