import AppKit

//private struct OffsetPosition: Hashable {
//
//    let x: Int
//    let y: Int
//
//    static func == (lhs: OffsetPosition, rhs: OffsetPosition) -> Bool {
//        return lhs.x == rhs.x && lhs.y == rhs.x
//    }
//
//    var hashValue: Int {
//        return x.hashValue & y.hashValue.byteSwapped
//    }
//
//}
//
//private extension OffsetPosition {
//
//    init?(x: Int, y: Int, width: Int, height: Int) {
//        guard x >= 0, y >= 0, x < width, y < height else {
//            return nil
//        }
//        self.x = x
//        self.y = y
//    }
//
//}

public extension CGContext {

    public func dither(allowedColors: [RGBA]) {
        guard let bitmap = data else {
            fatalError()
        }
        let colors = bitmap.bindMemory(to: RGBA.self, capacity: width * height)
        var offsets: [Int: [Int: Int16]] = [:]

        let rowWidth = (bytesPerRow / (bitsPerPixel / 8))
        for y in 0..<height {
            let rowOffset = rowWidth * y
            for x in 0..<width {
                let position = x + rowOffset
                let baseColor: RGBA = colors[position]
                let results: [ColorComparison]
                if let currentOffset = offsets[x]?[y] {
                    results = allowedColors.map(ColorComparison.comparison(to: baseColor, offsetBy: currentOffset))
                    offsets[x]?[y] = nil
                }
                else {
                    results = allowedColors.map(ColorComparison.comparison(to: baseColor))
                }
                let sorted = results.sorted(by: ColorComparison.sort)
//              Floyd-Stienberg
//                let errorFraction: Float = Float(sorted[0].difference) / 16
//                let diffusion: [(Int, Int, Int16)] = [
//                    (1, 0, Int16(errorFraction * 7)),
//                    (-1, 1, Int16(errorFraction * 3)),
//                    (0, 1, Int16(errorFraction * 5)),
//                    (1, 1, Int16(errorFraction * 1)),
//                ]
//              Atkinson
//                let errorFraction: Float = Float(sorted[0].difference) / 8
//                let diffusion: [(Int, Int, Int16)] = [
//                    (1, 0, Int16(errorFraction)),
//                    (2, 0, Int16(errorFraction)),
//                    (-1, 1, Int16(errorFraction)),
//                    (0, 1, Int16(errorFraction)),
//                    (1, 1, Int16(errorFraction)),
//                    (0, 2, Int16(errorFraction)),
//                    ]
//              Sierra
                let errorFraction: Float = Float(sorted[0].difference) / 32
                let diffusion: [(Int, Int, Int16)] = [
                    (1, 0, Int16(errorFraction * 5)),
                    (2, 0, Int16(errorFraction * 3)),
                    (-2, 1, Int16(errorFraction * 2)),
                    (-1, 1, Int16(errorFraction * 4)),
                    (0, 1, Int16(errorFraction * 5)),
                    (1, 1, Int16(errorFraction * 4)),
                    (2, 1, Int16(errorFraction * 2)),
                    (-1, 2, Int16(errorFraction * 2)),
                    (0, 2, Int16(errorFraction * 3)),
                    (1, 2, Int16(errorFraction * 2)),
                    ]
                for (xOff, yOff, error) in diffusion {
                    let xTarget = x + xOff
                    let yTarget = y + yOff
                    if xTarget >= 0, yTarget >= 0, xTarget < width, yTarget < height {
                        if offsets[xTarget] == nil {
                            offsets[xTarget] = [:]
                        }
                        let current = offsets[xTarget]?[yTarget] ?? 0
                        let offset = Int16.addWithOverflow(current, error).0
                        offsets[xTarget]?[yTarget] = offset
                    }
                }
                colors[position] = sorted[0].color
            }
        }

    }

}
