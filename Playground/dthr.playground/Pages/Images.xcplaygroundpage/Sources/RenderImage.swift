import AppKit
import dthr

public func renderImage(named: String, using pattern: DitherPattern, with conversion: GrayscaleConversion) -> (NSImage, NSImage) {
    guard let initial = NSImage(named: named) else {
        fatalError()
    }

    guard let ctx = NSGraphicsContext(width: Int(initial.size.width), height: Int(initial.size.height)) else {
        fatalError()
    }

    guard let cgImage = initial.cgImage(forProposedRect: nil, context: ctx, hints: nil) else {
        fatalError()
    }
    ctx.cgContext.draw(cgImage, in: CGRect(origin: CGPoint(), size: initial.size))

    ctx.cgContext.dither(allowedColors: [0, 255].map(RGBA.init(white:)), pattern: pattern, using: conversion)
    guard let cgImage2 = ctx.cgContext.makeImage() else {
        fatalError()
    }
    let dithered = NSImage(cgImage: cgImage2, size: CGSize(width: ctx.cgContext.width, height: ctx.cgContext.height))
    return (initial, dithered)
}
