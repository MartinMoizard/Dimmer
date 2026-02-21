import AppKit

let size: CGFloat = 1024
let image = NSImage(size: NSSize(width: size, height: size))

image.lockFocus()
guard let context = NSGraphicsContext.current?.cgContext else { exit(1) }

let colorSpace = CGColorSpaceCreateDeviceRGB()

// === Background gradient ===
let bgColors = [
    CGColor(red: 1.0, green: 0.75, blue: 0.0, alpha: 1.0),   // pure saturated gold
    CGColor(red: 1.0, green: 0.2, blue: 0.1, alpha: 1.0),    // electric red-orange
    CGColor(red: 0.75, green: 0.0, blue: 0.55, alpha: 1.0),  // neon magenta
    CGColor(red: 0.2, green: 0.0, blue: 0.5, alpha: 1.0),    // vivid deep purple
] as CFArray
let bgGradient = CGGradient(colorsSpace: colorSpace, colors: bgColors, locations: [0.0, 0.35, 0.7, 1.0])!
context.drawLinearGradient(bgGradient, start: CGPoint(x: 0, y: size), end: CGPoint(x: size, y: 0), options: [])

let eclipseCenter = CGPoint(x: size * 0.5, y: size * 0.52)
let sunRadius: CGFloat = size * 0.28

// === Ambient glow (subtle warmth around eclipse) ===
let ambientGlow = CGGradient(colorsSpace: colorSpace, colors: [
    CGColor(red: 1.0, green: 0.8, blue: 0.4, alpha: 0.18),
    CGColor(red: 1.0, green: 0.7, blue: 0.3, alpha: 0.08),
    CGColor(red: 1.0, green: 0.5, blue: 0.2, alpha: 0.0),
] as CFArray, locations: [0.0, 0.5, 1.0])!
context.drawRadialGradient(ambientGlow,
    startCenter: eclipseCenter, startRadius: sunRadius,
    endCenter: eclipseCenter, endRadius: size * 0.6,
    options: [])

// === Outer corona ===
let outerCorona = CGGradient(colorsSpace: colorSpace, colors: [
    CGColor(red: 1.0, green: 0.85, blue: 0.5, alpha: 0.45),
    CGColor(red: 1.0, green: 0.7, blue: 0.35, alpha: 0.25),
    CGColor(red: 1.0, green: 0.6, blue: 0.25, alpha: 0.1),
    CGColor(red: 1.0, green: 0.5, blue: 0.2, alpha: 0.0),
] as CFArray, locations: [0.0, 0.3, 0.6, 1.0])!
context.drawRadialGradient(outerCorona,
    startCenter: eclipseCenter, startRadius: sunRadius * 0.9,
    endCenter: eclipseCenter, endRadius: sunRadius * 2.8,
    options: [])

// === Middle corona ===
let midCorona = CGGradient(colorsSpace: colorSpace, colors: [
    CGColor(red: 1.0, green: 0.85, blue: 0.5, alpha: 0.65),
    CGColor(red: 1.0, green: 0.75, blue: 0.35, alpha: 0.4),
    CGColor(red: 1.0, green: 0.6, blue: 0.25, alpha: 0.12),
    CGColor(red: 1.0, green: 0.5, blue: 0.2, alpha: 0.0),
] as CFArray, locations: [0.0, 0.3, 0.6, 1.0])!
context.drawRadialGradient(midCorona,
    startCenter: eclipseCenter, startRadius: sunRadius * 0.95,
    endCenter: eclipseCenter, endRadius: sunRadius * 1.9,
    options: [])

// === Inner corona (bright white-gold ring) ===
let innerCorona = CGGradient(colorsSpace: colorSpace, colors: [
    CGColor(red: 1.0, green: 0.98, blue: 0.9, alpha: 1.0),
    CGColor(red: 1.0, green: 0.92, blue: 0.7, alpha: 0.7),
    CGColor(red: 1.0, green: 0.85, blue: 0.5, alpha: 0.3),
    CGColor(red: 1.0, green: 0.7, blue: 0.35, alpha: 0.0),
] as CFArray, locations: [0.0, 0.15, 0.4, 1.0])!
context.drawRadialGradient(innerCorona,
    startCenter: eclipseCenter, startRadius: sunRadius * 0.97,
    endCenter: eclipseCenter, endRadius: sunRadius * 1.45,
    options: [])

// === Bright rim ===
let rimGlow = CGGradient(colorsSpace: colorSpace, colors: [
    CGColor(red: 1.0, green: 1.0, blue: 0.95, alpha: 0.0),
    CGColor(red: 1.0, green: 1.0, blue: 0.95, alpha: 0.95),
    CGColor(red: 1.0, green: 0.97, blue: 0.85, alpha: 0.95),
    CGColor(red: 1.0, green: 0.9, blue: 0.65, alpha: 0.0),
] as CFArray, locations: [0.0, 0.43, 0.53, 1.0])!
context.drawRadialGradient(rimGlow,
    startCenter: eclipseCenter, startRadius: sunRadius * 0.82,
    endCenter: eclipseCenter, endRadius: sunRadius * 1.25,
    options: [])

// === Moon disc ===
let moonRadius: CGFloat = sunRadius * 0.92
let moonCenter = CGPoint(x: eclipseCenter.x + sunRadius * 0.03, y: eclipseCenter.y - sunRadius * 0.02)

context.saveGState()
context.beginPath()
context.addArc(center: moonCenter, radius: moonRadius, startAngle: 0, endAngle: .pi * 2, clockwise: false)
context.clip()

// Moon base
let moonGrad = CGGradient(colorsSpace: colorSpace, colors: [
    CGColor(red: 0.07, green: 0.05, blue: 0.14, alpha: 1.0),
    CGColor(red: 0.04, green: 0.03, blue: 0.09, alpha: 1.0),
] as CFArray, locations: [0.0, 1.0])!
context.drawRadialGradient(moonGrad,
    startCenter: CGPoint(x: moonCenter.x - moonRadius * 0.3, y: moonCenter.y + moonRadius * 0.3),
    startRadius: 0,
    endCenter: moonCenter,
    endRadius: moonRadius,
    options: [])

// Glassy sheen on moon (subtle light reflection)
let moonSheen = CGGradient(colorsSpace: colorSpace, colors: [
    CGColor(red: 0.5, green: 0.45, blue: 0.65, alpha: 0.1),
    CGColor(red: 0.3, green: 0.25, blue: 0.45, alpha: 0.03),
    CGColor(red: 0.2, green: 0.15, blue: 0.3, alpha: 0.0),
] as CFArray, locations: [0.0, 0.4, 1.0])!
context.drawRadialGradient(moonSheen,
    startCenter: CGPoint(x: moonCenter.x - moonRadius * 0.4, y: moonCenter.y + moonRadius * 0.45),
    startRadius: 0,
    endCenter: moonCenter,
    endRadius: moonRadius * 0.85,
    options: [])

context.restoreGState()

// === Diamond ring bead (moderate brightness) ===
let beadAngle: CGFloat = .pi * 0.3
let beadCenter = CGPoint(
    x: eclipseCenter.x + cos(beadAngle) * sunRadius * 0.98,
    y: eclipseCenter.y + sin(beadAngle) * sunRadius * 0.98)

let beadOuter = CGGradient(colorsSpace: colorSpace, colors: [
    CGColor(red: 1.0, green: 0.97, blue: 0.85, alpha: 0.7),
    CGColor(red: 1.0, green: 0.88, blue: 0.55, alpha: 0.2),
    CGColor(red: 1.0, green: 0.75, blue: 0.35, alpha: 0.0),
] as CFArray, locations: [0.0, 0.3, 1.0])!
context.drawRadialGradient(beadOuter,
    startCenter: beadCenter, startRadius: 0,
    endCenter: beadCenter, endRadius: sunRadius * 0.4,
    options: [])

let beadCore = CGGradient(colorsSpace: colorSpace, colors: [
    CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.95),
    CGColor(red: 1.0, green: 0.95, blue: 0.8, alpha: 0.4),
    CGColor(red: 1.0, green: 0.85, blue: 0.5, alpha: 0.0),
] as CFArray, locations: [0.0, 0.2, 1.0])!
context.drawRadialGradient(beadCore,
    startCenter: beadCenter, startRadius: 0,
    endCenter: beadCenter, endRadius: sunRadius * 0.2,
    options: [])

// === Stars with soft glow ===
for (px, py, r, a): (CGFloat, CGFloat, CGFloat, CGFloat) in [
    (0.12, 0.82, 2.8, 0.45), (0.88, 0.15, 3.2, 0.5), (0.92, 0.38, 2.2, 0.35),
    (0.08, 0.25, 2.2, 0.35), (0.78, 0.08, 2.8, 0.4), (0.15, 0.55, 1.8, 0.3),
    (0.85, 0.78, 2.2, 0.35), (0.22, 0.12, 2.5, 0.38), (0.93, 0.58, 1.8, 0.28),
    (0.05, 0.70, 1.8, 0.28), (0.72, 0.92, 2.2, 0.32),
] {
    let starCenter = CGPoint(x: size * px, y: size * py)
    // Soft halo
    let starGlow = CGGradient(colorsSpace: colorSpace, colors: [
        CGColor(red: 1.0, green: 0.95, blue: 0.85, alpha: a * 0.3),
        CGColor(red: 1.0, green: 0.9, blue: 0.8, alpha: 0.0),
    ] as CFArray, locations: [0.0, 1.0])!
    context.drawRadialGradient(starGlow, startCenter: starCenter, startRadius: 0, endCenter: starCenter, endRadius: r * 3.5, options: [])
    // Dot
    context.setFillColor(CGColor(red: 1.0, green: 0.98, blue: 0.9, alpha: a))
    context.beginPath()
    context.addArc(center: starCenter, radius: r, startAngle: 0, endAngle: .pi * 2, clockwise: false)
    context.fillPath()
}

image.unlockFocus()

let scriptURL = URL(fileURLWithPath: CommandLine.arguments[0]).deletingLastPathComponent()
let outputPath = scriptURL.appendingPathComponent("Dimmer/Assets.xcassets/AppIcon.appiconset").path

let sizes = [16, 32, 64, 128, 256, 512, 1024]
for s in sizes {
    let bmp = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: s, pixelsHigh: s,
        bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
        colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
    bmp.size = NSSize(width: s, height: s) // 1x scale (pixels == points)
    let ctx = NSGraphicsContext(bitmapImageRep: bmp)!
    NSGraphicsContext.current = ctx
    image.draw(in: NSRect(x: 0, y: 0, width: s, height: s),
               from: NSRect(x: 0, y: 0, width: size, height: size),
               operation: .copy, fraction: 1.0)
    NSGraphicsContext.current = nil
    guard let pngData = bmp.representation(using: .png, properties: [:]) else { continue }
    try! pngData.write(to: URL(fileURLWithPath: "\(outputPath)/icon_\(s).png"))
}
print("All icon sizes generated in \(outputPath)")
