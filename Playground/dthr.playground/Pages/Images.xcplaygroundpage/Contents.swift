//: [Previous](@previous)

import AppKit
import dthr

// test images from https://unsplash.com
/*
let (a, b) = renderImage(named: "test1", using: .floydStienberg, with: .hsl)
a
b
let (c, d) = renderImage(named: "test2", using: .atkinson, with: .decomposeMax)
c
d
 */
let (e, f) = renderImage(named: "test3", using: .sierraThree, with: .perceptual)
e
f

let(_, g) = renderImage(named: "test3", using: .floydStienberg, with: .bt601)
//let(_, h) = renderImage(named: "test3", using: .jarvisJudiceNink, with: .bt601)
//let(_, i) = renderImage(named: "test3", using: .stucki, with: .bt601)
let(_, j) = renderImage(named: "test3", using: .atkinson, with: .bt601)
//let(_, k) = renderImage(named: "test3", using: .burkes, with: .bt601)
//let(_, l) = renderImage(named: "test3", using: .sierraThree, with: .bt601)
//let(_, m) = renderImage(named: "test3", using: .sierraTwo, with: .bt601)
//let(_, n) = renderImage(named: "test3", using: .sierraLite, with: .bt601)
//e
g
//h
//i
j
//k
//l
//m
//n
