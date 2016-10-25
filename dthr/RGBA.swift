import Foundation

public struct RGBA {
    var alpha: UInt8
    var red: UInt8
    var green: UInt8
    var blue: UInt8

    public static let white = RGBA(white: 255)
    public static let gray = RGBA(white: 127)
    public static let black = RGBA(white: 0)

    var bt601: UInt8 {
        let red = Float(self.red) * 0.299
        let green = Float(self.green) * 0.587
        let blue = Float(self.blue) * 0.114
        return UInt8(red + green + blue)
    }

    func difference(_ other: RGBA) -> Int16 {
        return Int16(self.bt601) - Int16(other.bt601)
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
