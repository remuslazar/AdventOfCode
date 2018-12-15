//: [Previous](@previous)

import Foundation

// AOC Day 4

// Format: [1518-09-06 00:44] falls asleep
let fileURL = Bundle.main.url(forResource: "day4-input", withExtension: "txt")!

let data = try! String(contentsOf: fileURL)
let lines = data
    .split(separator: "\n")
    .map { String($0) }

let table = GuardSleepTable(input: lines)

// Find the guard that has the most minutes asleep
let guardID = table.guardIDs
    .sorted { (l, r) -> Bool in return table.asleepMinutes(guardID: l) < table.asleepMinutes(guardID: r) }
    .last!

// What minute does that guard spend asleep the most?
var minutes: [Int] = .init(repeating: 0, count: 60)
table.asleepRanges(guardID: guardID).forEach { (range) in
    for minute in range {
        minutes[minute] += 1
    }
}
let mostAsleepMinute = minutes.enumerated()
    .sorted { (l,r) -> Bool in return l.element < r.element }
    .map { $0.offset }
    .last!

// What is the ID of the guard you chose multiplied by the minute?
mostAsleepMinute * guardID

//: [Next](@next)
