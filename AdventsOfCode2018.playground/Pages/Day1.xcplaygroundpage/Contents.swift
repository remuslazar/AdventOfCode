//: [Previous](@previous)

import Foundation

let fileURL = Bundle.main.url(forResource: "day1-input", withExtension: "txt")!

let data = try! String(contentsOf: fileURL)
let freqChangeList = data
    .split(separator: "\n")
    .map { Int($0)! }

let initialFrequency = 0
let result = freqChangeList.reduce(initialFrequency, +)

//: [Next](@next)
