import Foundation

public struct RGBA {
    var alpha: UInt8
    var red: UInt8
    var green: UInt8
    var blue: UInt8

    func difference(_ other: RGBA, using conversion: GrayscaleConversion) -> Int16 {
        return Int16(conversion.averageFunction(self)) &- Int16(conversion.averageFunction(other))
    }

    public init(red: UInt8, green: UInt8, blue: UInt8) {
        self.red = red
        self.blue = blue
        self.green = green
        self.alpha = 255
    }

    public init(white: UInt8) {
        self.red = white
        self.blue = white
        self.green = white
        self.alpha = 255
    }

}
