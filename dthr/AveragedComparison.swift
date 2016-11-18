import Foundation

struct AveragedColor {
    var color: RGBA
    var average: UInt8

    static func averager(using conversion: GrayscaleConversion) -> ((RGBA) -> AveragedColor) {
        return { color in
            return AveragedColor(color: color, average: conversion.averageFunction(color))
        }
    }
}

struct AveragedComparison {

    var averagedColor: AveragedColor
    var difference: Int16

    static func comparison(to color: AveragedColor, offsetBy: Int16) -> (AveragedColor) -> AveragedComparison {
        return { otherColor in
            let difference = Int16(color.average) &- Int16(otherColor.average)
            let offset = difference &+ offsetBy
            return AveragedComparison(averagedColor: otherColor, difference: offset)
        }
    }

    static func sort(lhs: AveragedComparison, rhs: AveragedComparison) -> Bool {
        let lDiff = abs(lhs.difference)
        let rDiff = abs(rhs.difference)
        return lDiff < rDiff
    }

}
