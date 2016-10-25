import Foundation

struct ColorComparison {

    let color: RGBA
    let difference: Int16

    static func comparison(to color: RGBA) -> (RGBA) -> ColorComparison {
        return { otherColor in
            return ColorComparison(color: otherColor, difference: Int16(abs(color.difference(otherColor))))
        }
    }

    static func comparison(to color: RGBA, offsetBy: Int16) -> (RGBA) -> ColorComparison {
        return { otherColor in
            let offset = Int16.addWithOverflow(color.difference(otherColor), offsetBy).0
            return ColorComparison(color: otherColor, difference: Int16(offset))
        }
    }

    static func sort(lhs: ColorComparison, rhs: ColorComparison) -> Bool {
        let lDiff = abs(lhs.difference)
        let rDiff = abs(rhs.difference)
        if lDiff == rDiff {
            return arc4random() > arc4random()
        }
        return lDiff < rDiff
    }
}
