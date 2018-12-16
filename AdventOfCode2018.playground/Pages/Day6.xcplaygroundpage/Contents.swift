/*:
 # Advent Of Code, Day 6
 */

import Foundation

let fileURL = Bundle.main.url(forResource: "day6-input", withExtension: "txt")!
let points = Set<Point>(try! String(contentsOf: fileURL)
    .trimmingCharacters(in: .newlines)
    .split(separator: "\n")
    .map { Point(line: $0) })

points.count

//: ## Part 1

//: Loop over each point and calculate the distance to all of the neighbors

Engine.calculateLargestArea(for: points)

//: ## Part 2
Engine.calculateRegion(near: points, maxDistance: 10000)

//: [Next](@next)
