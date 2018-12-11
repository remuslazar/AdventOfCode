//: [Previous](@previous)

import Foundation

// AOC Day 3

// Format; position=< 1,  6> velocity=< 1,  0>
let fileURL = Bundle.main.url(forResource: "day3-input-test", withExtension: "txt")!

let data = try! String(contentsOf: fileURL)
let claims = data
    .split(separator: "\n")
    .map { Claim(string: String($0)) }

let board = Board(claims: claims)

board.overlapArea


//: [Next](@next)
