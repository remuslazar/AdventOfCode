//: [Previous](@previous)

import Foundation

// AOC Day 5

// Format:
let fileURL = Bundle.main.url(forResource: "day5-input", withExtension: "txt")!
let data = try! String(contentsOf: fileURL).trimmingCharacters(in: .newlines)

let polymer = Polymer(data: data)
let reacted = polymer.react()

reacted.length

//: [Next](@next)
