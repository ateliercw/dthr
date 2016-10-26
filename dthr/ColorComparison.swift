import Foundation

struct ColorComparison {

    let color: RGBA
    let difference: Int16

    static func comparison(to color: RGBA, using conversion: GrayscaleConversion) -> (RGBA) -> ColorComparison {
        return comparison(to: color, using: conversion, offsetBy: 0)
    }

    static func comparison(to color: RGBA, using conversion: GrayscaleConversion, offsetBy: Int16) -> (RGBA) -> ColorComparison {
        return { otherColor in
            let offset = Int16.addWithOverflow(color.difference(otherColor, using: conversion), offsetBy).0
            return ColorComparison(color: otherColor, difference: Int16(offset))
        }
    }

    static func sort(lhs: ColorComparison, rhs: ColorComparison) -> Bool {
        let lDiff = abs(lhs.difference)
        let rDiff = abs(rhs.difference)
        return lDiff < rDiff
    }
}
