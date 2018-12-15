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
let guardID = table.guardIDs.max(by: { (l, r) -> Bool in return table.asleepMinutes(guardID: l) < table.asleepMinutes(guardID: r) })!

// What minute does that guard spend asleep the most?
func mostAsleepMinute(guardID: Int) -> Int {
    var minutes: [Int] = .init(repeating: 0, count: 60)
    table.asleepRanges(guardID: guardID).forEach { (range) in
        for minute in range { minutes[minute] += 1 }
    }
    return minutes.enumerated().max( by: { $0.element < $1.element })!.offset
}
// What is the ID of the guard you chose multiplied by the minute?

mostAsleepMinute(guardID: guardID) * guardID

// Part 2
// Strategy 2: Of all guards, which guard is most frequently asleep on the same minute?
let guardIDMostAsleepMinutes = table.guardIDs
    .map { ($0, mostAsleepMinute(guardID: $0)) }
    .max { $0.1 < $1.1 }!

// guard ID
guardIDMostAsleepMinutes.0
// most asleep minute
guardIDMostAsleepMinutes.1

// What is the ID of the guard you chose multiplied by the minute
guardIDMostAsleepMinutes.0 * guardIDMostAsleepMinutes.1


//: [Next](@next)
