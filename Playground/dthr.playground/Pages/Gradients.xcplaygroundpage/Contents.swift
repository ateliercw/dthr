import AppKit
import dthr

let gradientPoints = [GradientPoint(position: 0, color: .white), GradientPoint(position: 1, color: .black)]

guard let newContext = NSGraphicsContext(width: 640, height: 480) else {
    fatalError()
}
newContext.saveGraphicsState()
defer {
    newContext.restoreGraphicsState()
}
newContext.renderGradient(gradientPoints: gradientPoints) { _ in
}

newContext.renderGradient(gradientPoints: gradientPoints) { cgContext in
    let colors = [0, 255].map(RGBA.init(white:))
    cgContext.threshold(allowedColors: colors, using: .bt709)
}

newContext.renderGradient(gradientPoints: gradientPoints) { cgContext in
    let colors = [0, 255].map(RGBA.init(white:))
    cgContext.dither(allowedColors: colors, pattern: .floydStienberg, using: .bt709)
}

newContext

//: [Next](@next)
