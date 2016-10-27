import AppKit

public extension CGContext {

    public func threshold(allowedColors: [RGBA], using conversion: GrayscaleConversion) {
        guard let bitmap = data else {
            fatalError()
        }
        let colors = bitmap.bindMemory(to: RGBA.self, capacity: width * height)
        let comparisons = allowedColors.map(AveragedColor.averager(using: conversion))
        let rowWidth = (bytesPerRow / (bitsPerPixel / 8))
        for y in 0..<height {
            let rowOffset = rowWidth * y
            for x in 0..<width {
                let position = x + rowOffset
                let color = colors[position]
                let averagedColor = AveragedColor(color: color, average: conversion.averageFunction(color))
                let results = comparisons.map(AveragedComparison.comparison(to: averagedColor, offsetBy: 0))
                let sorted = results.sorted(by: AveragedComparison.sort)
                colors[position] = sorted[0].averagedColor.color
            }
        }

    }

}
