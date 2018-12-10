//: [Previous](@previous)

import Foundation

// AOC Day 10

// Format; position=< 1,  6> velocity=< 1,  0>
let fileURL = Bundle.main.url(forResource: "day10-input", withExtension: "txt")!

let data = try! String(contentsOf: fileURL)
let points = data
    .split(separator: "\n")
    .map { Point(string: String($0)) }

points.count

var display = Display(points: points)

if let seconds = display.foundMinimumViewportSize(maxSeconds: 100000) {
    print(seconds)
    display.advance(by: seconds)
    display.render(viewport: display.viewport)
}

//: [Next](@next)

