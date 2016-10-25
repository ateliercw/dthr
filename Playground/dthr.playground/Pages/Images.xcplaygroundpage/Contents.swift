//: [Previous](@previous)

import AppKit
import dthr

// test images from https://unsplash.com

let image1: NSImage = {
    guard let image = NSImage(named: "test1.jpg") else {
        fatalError()
    }

    guard let ctx = NSGraphicsContext(width: Int(image.size.width), height: Int(image.size.height)) else {
        fatalError()
    }

    ctx.saveGraphicsState()
    guard let cgImage = image.cgImage(forProposedRect: nil, context: ctx, hints: nil) else {
        fatalError()
    }
    ctx.cgContext.draw(cgImage, in: CGRect(origin: CGPoint(), size: image.size))
    guard let render1 = ctx.cgContext.makeImage() else {
        fatalError()
    }

    NSImage(cgImage: render1, size: CGSize(width: ctx.cgContext.width, height: ctx.cgContext.height))
    ctx.cgContext.dither(allowedColors: [0, 255].map(RGBA.init(white:)), pattern: .floydStienberg)
    guard let cgImage2 = ctx.cgContext.makeImage() else {
        fatalError()
    }
    return NSImage(cgImage: cgImage2, size: CGSize(width: ctx.cgContext.width, height: ctx.cgContext.height))
    ctx.restoreGraphicsState()

}()

let image2: NSImage = {
    guard let image = NSImage(named: "test2.jpg") else {
        fatalError()
    }

    guard let ctx = NSGraphicsContext(width: Int(image.size.width), height: Int(image.size.height)) else {
        fatalError()
    }

    ctx.saveGraphicsState()
    guard let cgImage = image.cgImage(forProposedRect: nil, context: ctx, hints: nil) else {
        fatalError()
    }
    ctx.cgContext.draw(cgImage, in: CGRect(origin: CGPoint(), size: image.size))
    guard let render1 = ctx.cgContext.makeImage() else {
        fatalError()
    }

    NSImage(cgImage: render1, size: CGSize(width: ctx.cgContext.width, height: ctx.cgContext.height))
    ctx.cgContext.dither(allowedColors: [0, 255].map(RGBA.init(white:)), pattern: .atkinson)
    guard let cgImage2 = ctx.cgContext.makeImage() else {
        fatalError()
    }
    return NSImage(cgImage: cgImage2, size: CGSize(width: ctx.cgContext.width, height: ctx.cgContext.height))
    ctx.restoreGraphicsState()

}()

let image3: NSImage = {
    guard let image = NSImage(named: "test3.jpg") else {
        fatalError()
    }

    guard let ctx = NSGraphicsContext(width: Int(image.size.width), height: Int(image.size.height)) else {
        fatalError()
    }

    ctx.saveGraphicsState()
    guard let cgImage = image.cgImage(forProposedRect: nil, context: ctx, hints: nil) else {
        fatalError()
    }
    ctx.cgContext.draw(cgImage, in: CGRect(origin: CGPoint(), size: image.size))
    guard let render1 = ctx.cgContext.makeImage() else {
        fatalError()
    }

    NSImage(cgImage: render1, size: CGSize(width: ctx.cgContext.width, height: ctx.cgContext.height))
    ctx.cgContext.dither(allowedColors: [0, 255].map(RGBA.init(white:)), pattern: .floydStienberg)
    guard let cgImage2 = ctx.cgContext.makeImage() else {
        fatalError()
    }
    return NSImage(cgImage: cgImage2, size: CGSize(width: ctx.cgContext.width, height: ctx.cgContext.height))
    ctx.restoreGraphicsState()

}()

let image4: NSImage = {
    guard let image = NSImage(named: "test3.jpg") else {
        fatalError()
    }

    guard let ctx = NSGraphicsContext(width: Int(image.size.width), height: Int(image.size.height)) else {
        fatalError()
    }

    ctx.saveGraphicsState()
    guard let cgImage = image.cgImage(forProposedRect: nil, context: ctx, hints: nil) else {
        fatalError()
    }
    ctx.cgContext.draw(cgImage, in: CGRect(origin: CGPoint(), size: image.size))
    guard let render1 = ctx.cgContext.makeImage() else {
        fatalError()
    }

    NSImage(cgImage: render1, size: CGSize(width: ctx.cgContext.width, height: ctx.cgContext.height))
    ctx.cgContext.dither(allowedColors: [0, 255].map(RGBA.init(white:)), pattern: .atkinson)
    guard let cgImage2 = ctx.cgContext.makeImage() else {
        fatalError()
    }
    return NSImage(cgImage: cgImage2, size: CGSize(width: ctx.cgContext.width, height: ctx.cgContext.height))
    ctx.restoreGraphicsState()
    
}()

let image5: NSImage = {
    guard let image = NSImage(named: "test3.jpg") else {
        fatalError()
    }

    guard let ctx = NSGraphicsContext(width: Int(image.size.width), height: Int(image.size.height)) else {
        fatalError()
    }

    ctx.saveGraphicsState()
    guard let cgImage = image.cgImage(forProposedRect: nil, context: ctx, hints: nil) else {
        fatalError()
    }
    ctx.cgContext.draw(cgImage, in: CGRect(origin: CGPoint(), size: image.size))
    guard let render1 = ctx.cgContext.makeImage() else {
        fatalError()
    }

    NSImage(cgImage: render1, size: CGSize(width: ctx.cgContext.width, height: ctx.cgContext.height))
    ctx.cgContext.dither(allowedColors: [0, 255].map(RGBA.init(white:)), pattern: .sierra)
    guard let cgImage2 = ctx.cgContext.makeImage() else {
        fatalError()
    }
    return NSImage(cgImage: cgImage2, size: CGSize(width: ctx.cgContext.width, height: ctx.cgContext.height))
    ctx.restoreGraphicsState()
}()
