import AppKit

public enum DitherPattern {
    case floydStienberg, jarvisJudiceNink, stucki, atkinson, burkes, sierraThree, sierraTwo, sierraLite

    private var divisor: Float {
        let divisor: Float
        switch self {
        case .floydStienberg: divisor = 16
        case .jarvisJudiceNink: divisor = 48
        case .stucki: divisor = 42
        case .atkinson: divisor = 8
        case .burkes: divisor = 32
        case .sierraThree: divisor = 32
        case .sierraTwo: divisor = 16
        case .sierraLite: divisor = 4
        }
        return divisor
    }

    fileprivate var pattern: [Point<Float>] {
        let points: [Point<Float>]
        switch self {
        case .floydStienberg:
            points = [
                Point(xOff: 1, yOff: 0, error: 7),
                Point(xOff: -1, yOff: 1, error: 3),
                Point(xOff: 0, yOff: 1, error: 5),
                Point(xOff: 1, yOff: 1, error: 1),
            ]
        case .jarvisJudiceNink:
            points = [
                Point(xOff: 1, yOff: 0, error: 7),
                Point(xOff: 2, yOff: 0, error: 5),
                Point(xOff: -2, yOff: 1, error: 3),
                Point(xOff: -1, yOff: 1, error: 5),
                Point(xOff: 0, yOff: 1, error: 7),
                Point(xOff: 1, yOff: 1, error: 5),
                Point(xOff: 2, yOff: 1, error: 3),
                Point(xOff: -2, yOff: 2, error: 1),
                Point(xOff: -1, yOff: 2, error: 3),
                Point(xOff: 0, yOff: 2, error: 5),
                Point(xOff: 1, yOff: 2, error: 3),
                Point(xOff: 2, yOff: 2, error: 1),
            ]
        case .stucki:
            points = [
                Point(xOff: 1, yOff: 0, error: 8),
                Point(xOff: 2, yOff: 0, error: 4),
                Point(xOff: -2, yOff: 1, error: 2),
                Point(xOff: -1, yOff: 1, error: 4),
                Point(xOff: 0, yOff: 1, error: 8),
                Point(xOff: 1, yOff: 1, error: 4),
                Point(xOff: 2, yOff: 1, error: 2),
                Point(xOff: -2, yOff: 2, error: 1),
                Point(xOff: -1, yOff: 2, error: 2),
                Point(xOff: 0, yOff: 2, error: 4),
                Point(xOff: 1, yOff: 2, error: 2),
                Point(xOff: 2, yOff: 2, error: 1),
            ]
        case .atkinson:
            points = [
                Point(xOff: 1, yOff: 0, error: 1),
                Point(xOff: 2, yOff: 0, error: 1),
                Point(xOff: -1, yOff: 1, error: 1),
                Point(xOff: 0, yOff: 1, error: 1),
                Point(xOff: 1, yOff: 1, error: 1),
                Point(xOff: 0, yOff: 2, error: 1),
            ]
        case .burkes:
            points = [
                Point(xOff: 1, yOff: 0, error: 8),
                Point(xOff: 2, yOff: 0, error: 4),
                Point(xOff: -2, yOff: 1, error: 2),
                Point(xOff: -1, yOff: 1, error: 4),
                Point(xOff: 0, yOff: 1, error: 8),
                Point(xOff: 1, yOff: 1, error: 4),
                Point(xOff: 2, yOff: 1, error: 2),
            ]
        case .sierraThree:
            points = [
                Point(xOff: 1, yOff: 0, error: 5),
                Point(xOff: 2, yOff: 0, error: 3),
                Point(xOff: -2, yOff: 1, error: 2),
                Point(xOff: -1, yOff: 1, error: 4),
                Point(xOff: 0, yOff: 1, error: 5),
                Point(xOff: 1, yOff: 1, error: 4),
                Point(xOff: 2, yOff: 1, error: 2),
                Point(xOff: -1, yOff: 2, error: 2),
                Point(xOff: 0, yOff: 2, error: 3),
                Point(xOff: 1, yOff: 2, error: 2),
            ]
        case .sierraTwo:
            points = [
                Point(xOff: 1, yOff: 0, error: 4),
                Point(xOff: 2, yOff: 0, error: 3),
                Point(xOff: -2, yOff: 1, error: 1),
                Point(xOff: -1, yOff: 1, error: 2),
                Point(xOff: 0, yOff: 1, error: 3),
                Point(xOff: 1, yOff: 1, error: 2),
                Point(xOff: 2, yOff: 1, error: 1),
            ]
        case .sierraLite:
            points = [
                Point(xOff: 1, yOff: 0, error: 2),
                Point(xOff: -1, yOff: 1, error: 1),
                Point(xOff: 0, yOff: 1, error: 1),
            ]
        }

        return points
    }

    fileprivate func diffused(error: Float, x: Int, y: Int, width: Int, height: Int) -> [Point<Int16>] {
        let errorPoint = error / divisor
        return pattern.flatMap { initialPoint in
            let finalX = x + initialPoint.xOff
            let finalY = y + initialPoint.yOff
            guard finalX >= 0, finalY >= 0, finalX < width, finalY < height else {
                return nil
            }
            return Point(xOff: finalX, yOff: finalY, error: Int16(errorPoint * initialPoint.error))
        }
    }
}

private struct Point<Value> {
    let xOff: Int, yOff: Int, error: Value
}

public extension CGContext {

    public func dither(allowedColors: [RGBA], pattern: DitherPattern, using conversion: GrayscaleConversion) {
        guard let colors = data?.bindMemory(to: RGBA.self, capacity: width * height) else {
            fatalError()
        }
        let offsets = UnsafeMutablePointer<Int16>.allocate(capacity: width * height)
        offsets.initialize(to: 0, count: width * height)
        defer {
            offsets.deinitialize()
            offsets.deallocate(capacity: width * height)
        }
        let comparisons = allowedColors.map(AveragedColor.averager(using: conversion))
        let rowWidth = (bytesPerRow / (bitsPerPixel / 8))
        for y in 0..<height {
            let rowOffset = rowWidth * y
            let errorOffset = y * width
            for x in 0..<width {
                let position = x + rowOffset
                let average = conversion.averageFunction(colors[position])
                let averagedColor = AveragedColor(color: colors[position], average: average)
                let currentOffset = offsets[x + errorOffset]
                let results = comparisons.map(AveragedComparison.comparison(to: averagedColor, offsetBy: currentOffset))
                let sorted = results.sorted(by: AveragedComparison.sort)
                let error = sorted[0].difference
                let diffusion = pattern.diffused(error: Float(error), x: x, y: y, width: width, height: height)
                for point in diffusion {
                    let arrayPosition = point.xOff + (point.yOff * width)
                    let start = offsets[arrayPosition]
                    offsets[arrayPosition] = Int16.addWithOverflow(start, point.error).0
                }
                colors[position] = sorted[0].averagedColor.color
            }
        }
    }

}
