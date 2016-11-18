//
//  GrayscaleConversion.swift
//  dthr
//
//  Created by Michael Skiba on 10/25/16.
//  Copyright © 2016 Michael Skiba. All rights reserved.
//

import Foundation

public enum GrayscaleConversion {

    case linear, hsl, perceptual, bt601, bt709, decomposeMax, decomposeMin, custom(rMult: Float, gMult: Float, bMult: Float), other(conversion: (RGBA) -> UInt8)

    public var averageFunction: ((RGBA) -> UInt8) {
        let averageFunction: (RGBA) -> UInt8
        switch self {
        case .linear: averageFunction =  Formulas.linear(color:)
        case .hsl: averageFunction = Formulas.hsl(color:)
        case .perceptual: averageFunction = Formulas.perceptual(color:)
        case .bt601: averageFunction = Formulas.bt601(color:)
        case .bt709: averageFunction = Formulas.bt709(color:)
        case .custom(rMult: let rMult, gMult: let gMult, bMult: let bMult):
            averageFunction = Formulas.custom(rMult: rMult, gMult: gMult, bMult: bMult)
        case .decomposeMax: averageFunction = Formulas.decomposeMax(color:)
        case .decomposeMin: averageFunction = Formulas.decomposeMin(color:)
        case .other(conversion: let conversion):
            averageFunction = conversion
        }
        return averageFunction
    }

}

public extension CGContext {

    public func convertToGrayscale(using formula: GrayscaleConversion) {
        guard let bitmap = data else {
            fatalError()
        }
        let colors = bitmap.bindMemory(to: RGBA.self, capacity: width * height)

        let rowWidth = (bytesPerRow / (bitsPerPixel / 8))
        for y in 0..<height {
            let rowOffset = rowWidth * y
            for x in 0..<width {
                let position = x + rowOffset
                colors[position] = RGBA(white: formula.averageFunction(colors[position]))
            }
        }

    }

}

private func min(_ a: UInt8, _ b: UInt8, _ c: UInt8) -> UInt8 {
    return min(min(a, b), c)
}

private func max(_ a: UInt8, _ b: UInt8, _ c: UInt8) -> UInt8 {
    return max(max(a, b), c)
}

private extension GrayscaleConversion {

    struct Formulas {
        static func linear(color: RGBA) -> UInt8 {
            return UInt8((UInt16(color.red) + UInt16(color.blue) + UInt16(color.green)) / 3)
        }

        static func hsl(color: RGBA) -> UInt8 {
            let maxChannel = max(color.red, color.blue, color.green)
            let minChannel = min(color.red, color.blue, color.green)
            return UInt8((UInt16(maxChannel) + UInt16(minChannel)) / 2)
        }

        static func decomposeMax(color: RGBA) -> UInt8 {
            return max(color.red, color.blue, color.green)
        }

        static func decomposeMin(color: RGBA) -> UInt8 {
            return min(color.red, color.blue, color.green)
        }

        static func perceptual(color: RGBA) -> UInt8 {
            return multiply(color: color, rMult: 0.3, gMult: 0.59, bMult: 0.11)
        }

        static func bt601(color: RGBA) -> UInt8 {
            return multiply(color: color, rMult: 0.299, gMult: 0.587, bMult: 0.114)
        }

        static func bt709(color: RGBA) -> UInt8 {
            return multiply(color: color, rMult: 0.2126, gMult: 0.7152, bMult: 0.0722)
        }

        static func custom(rMult: Float, gMult: Float, bMult: Float) -> ((RGBA) -> UInt8) {
            return { color in
                return multiply(color: color, rMult: rMult, gMult: gMult, bMult: bMult)
            }
        }

        static func multiply(color: RGBA, rMult: Float, gMult: Float, bMult: Float) -> UInt8 {
            let red = Float(color.red) * rMult
            let green = Float(color.green) * gMult
            let blue = Float(color.blue) * bMult
            let rPlusGplusB = UInt8(red) &+ UInt8(green) &+ UInt8(blue)
            return rPlusGplusB
        }
    }

}
