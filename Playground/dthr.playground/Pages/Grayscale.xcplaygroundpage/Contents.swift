//: [Previous](@previous)

import AppKit
import dthr

guard let test1 = NSImage(named: "test1.jpg") else {
    fatalError()
}
test1
renderImage(image: test1, using: .linear)
renderImage(image: test1, using: .hsl)
renderImage(image: test1, using: .perceptual)
renderImage(image: test1, using: .bt709)
renderImage(image: test1, using: .bt601)
renderImage(image: test1, using: .decomposeMax)
renderImage(image: test1, using: .decomposeMin)
renderImage(image: test1, using: .custom(rMult: 1, gMult: 0, bMult: 0))

guard let test2 = NSImage(named: "test2.jpg") else {
    fatalError()
}
test2
renderImage(image: test2, using: .linear)
renderImage(image: test2, using: .hsl)
renderImage(image: test2, using: .perceptual)
renderImage(image: test2, using: .bt709)
renderImage(image: test2, using: .bt601)
renderImage(image: test2, using: .decomposeMax)
renderImage(image: test2, using: .decomposeMin)
renderImage(image: test2, using: .custom(rMult: 0, gMult: 1, bMult: 0))

guard let test3 = NSImage(named: "test3.jpg") else {
    fatalError()
}
test3
renderImage(image: test3, using: .linear)
renderImage(image: test3, using: .hsl)
renderImage(image: test3, using: .perceptual)
renderImage(image: test3, using: .bt709)
renderImage(image: test3, using: .bt601)
renderImage(image: test3, using: .decomposeMax)
renderImage(image: test3, using: .decomposeMin)
renderImage(image: test3, using: .custom(rMult: 0, gMult: 1, bMult: 0))
