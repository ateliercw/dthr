import AppKit

public struct GradientPoint {
    public let position: CGFloat
    public let color: NSColor

    public init(position: CGFloat, color: NSColor) {
        self.position = position
        self.color = color
    }
}
