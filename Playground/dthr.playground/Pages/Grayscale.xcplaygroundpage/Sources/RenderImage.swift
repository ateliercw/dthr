import AppKit
import dthr

public func renderImage(image: NSImage, using conversion: GrayscaleConversion) -> NSImage {
    guard let ctx = NSGraphicsContext(width: Int(image.size.width), height: Int(image.size.height)) else {
        fatalError()
    }
    ctx.saveGraphicsState()
    defer {
        ctx.restoreGraphicsState()
    }
    guard let cgImage = image.cgImage(forProposedRect: nil, context: ctx, hints: nil) else {
        fatalError()
    }
    ctx.cgContext.draw(cgImage, in: CGRect(origin: CGPoint(), size: image.size))
    return ctx.convertToGrayscale(using: conversion)
}
