//: [Previous](@previous)

import Foundation

// AOC Day 5

// Format:
let fileURL = Bundle.main.url(forResource: "day5-input", withExtension: "txt")!
let data = try! String(contentsOf: fileURL)

let polymer = Polymer(data: data)

let reacted = polymer.react()

print(reacted)

//: [Next](@next)
