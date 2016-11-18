//
//  main.swift
//  dthr-cli
//
//  Created by Michael Skiba on 10/27/16.
//  Copyright © 2016 Michael Skiba. All rights reserved.
//

import Foundation
import AppKit

let arguments = CommandLine.arguments.dropFirst().flatMap(URL.init(fileURLWithPath:))

guard arguments.count == 2,
    let inFile = arguments.first,
    let outFile = arguments.last else {
    fatalError("Requires exactly 2 arguments")
}

public func render(_ image: NSImage, using pattern: DitherPattern, with conversion: GrayscaleConversion) -> NSImage {
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

    ctx.cgContext.dither(allowedColors: [0, 255].map(RGBA.init(white:)), pattern: pattern, using: conversion)
    guard let cgImage2 = ctx.cgContext.makeImage() else {
        fatalError()
    }
    let dithered = NSImage(cgImage: cgImage2, size: CGSize(width: ctx.cgContext.width, height: ctx.cgContext.height))
    return dithered
}

guard let image = NSImage(contentsOf: inFile) else {
    fatalError("Failed to load input image: \(inFile)")
}

let dithered = render(image, using: .atkinson, with: .bt601)

dithered.lockFocus()
let ditheredRep = NSBitmapImageRep.init(focusedViewRect: NSRect(origin: CGPoint(), size: dithered.size))
dithered.unlockFocus()
guard let data = ditheredRep?.representation(using: NSPNGFileType, properties: [:]) else {
    fatalError("Failed to create png")
}
do {
    try data.write(to: outFile, options: .atomicWrite)
}
catch {
    print("Failed to write output")
}
