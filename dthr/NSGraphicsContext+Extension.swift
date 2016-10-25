import AppKit

public extension NSGraphicsContext {

    public convenience init?(width: Int, height: Int) {
        guard let bmpRep = NSBitmapImageRep(bitmapDataPlanes: nil,
                                            pixelsWide: width,
                                            pixelsHigh: height,
                                            bitsPerSample: 8,
                                            samplesPerPixel: 4,
                                            hasAlpha: true,
                                            isPlanar: false,
                                            colorSpaceName: NSDeviceRGBColorSpace,
                                            bitmapFormat: .alphaFirst,
                                            bytesPerRow: 0,
                                            bitsPerPixel: 0) else {
                                                fatalError()
        }

        self.init(bitmapImageRep: bmpRep)
    }

    public func renderGradient(gradientPoints: [GradientPoint], manipulation: (CGContext) -> Void) -> NSImage {
        cgContext.drawLinearGradient(gradientPoints.gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: cgContext.width, y: 0), options: [])
        manipulation(cgContext)
        guard let cgImage = cgContext.makeImage() else {
            fatalError()
        }
        return NSImage(cgImage: cgImage, size: CGSize(width: cgContext.width, height: cgContext.height))
    }
}
