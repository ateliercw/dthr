import AppKit

public extension CGContext {

    public func threshold(allowedColors: [RGBA], using conversion: GrayscaleConversion) {
        guard let bitmap = data else {
            fatalError()
        }
        let colors = bitmap.bindMemory(to: RGBA.self, capacity: width * height)

        let rowWidth = (bytesPerRow / (bitsPerPixel / 8))
        for y in 0..<height {
            let rowOffset = rowWidth * y
            for x in 0..<width {
                let position = x + rowOffset
                let results = allowedColors.map(ColorComparison.comparison(to: colors[position], using: conversion))
                let sorted = results.sorted(by: ColorComparison.sort)
                colors[position] = sorted[0].color
            }
        }

    }

}
