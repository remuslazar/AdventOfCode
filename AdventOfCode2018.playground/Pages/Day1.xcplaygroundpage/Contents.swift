//: [Previous](@previous)

import Foundation

let fileURL = Bundle.main.url(forResource: "day1-input", withExtension: "txt")!

let data = try! String(contentsOf: fileURL)
let freqChangeListData = data
    .split(separator: "\n")
    .map { Int($0)! }

let initialFrequency = 0
let result = freqChangeListData.reduce(initialFrequency, +)

// Part 2: Calibration

var freqChangeList = FreqChangeList(freqChangeListData)
let processor = FreqProcessor(freqChangeList)

processor.firstAlreadySeenFrequency

//: [Next](@next)
