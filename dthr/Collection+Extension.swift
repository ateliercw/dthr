import AppKit

extension CGColor {
    func components(in colorSpace: CGColorSpace) -> [CGFloat] {
        let colors: [CGFloat]
        if self.colorSpace?.model == colorSpace.model {
            colors = components ?? []
        }
        else {
            colors = converted(to: colorSpace, intent: .defaultIntent, options: nil)?.components ?? []
        }
        return colors
    }
}

public extension Collection where Iterator.Element == GradientPoint, IndexDistance == Int {

    var positions: UnsafePointer<CGFloat> {
        let pointer = UnsafeMutablePointer<CGFloat>.allocate(capacity: self.count)
        for (index, point) in self.enumerated() {
            pointer[index] = point.position
        }
        return UnsafePointer(pointer)
    }

    var colors: UnsafePointer<CGFloat> {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorArray = flatMap { $0.color.cgColor.components(in: colorSpace) }
        let pointer = UnsafeMutablePointer<CGFloat>.allocate(capacity: colorArray.count)
        for (index, color) in colorArray.enumerated() {
            pointer[index] = color
        }
        return UnsafePointer(pointer)
    }

    public var gradient: CGGradient {
        return CGGradient(colorSpace: CGColorSpaceCreateDeviceRGB(), colorComponents: colors, locations: positions, count: count)!
    }

}
