import AppKit
import dthr

let gradientPoints = [GradientPoint(position: 0, color: .white), GradientPoint(position: 1, color: .black)]

guard let newContext = NSGraphicsContext(width: 640, height: 480) else {
    fatalError()
}
newContext.saveGraphicsState()
newContext.renderGradient(gradientPoints: gradientPoints) { cgContext in
}
newContext.renderGradient(gradientPoints: gradientPoints) { cgContext in
    let colors = [0, 32, 64, 96, 127, 159, 191, 223, 255].map(RGBA.init(white:))
    cgContext.threshold(allowedColors: colors)
}
newContext.renderGradient(gradientPoints: gradientPoints) { cgContext in
    let colors = [0, 255].map(RGBA.init(white:))
    cgContext.dither(allowedColors: colors)
}
newContext.renderGradient(gradientPoints: gradientPoints) { cgContext in
    let colors = [0, 32, 64, 96, 127, 159, 191, 223, 255].map(RGBA.init(white:))
    cgContext.dither(allowedColors: colors)
}
newContext.restoreGraphicsState()

//: [Next](@next)
