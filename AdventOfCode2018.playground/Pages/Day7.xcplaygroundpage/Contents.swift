//: [Previous](@previous)

/*:
 # Advent Of Code, Day 7
 */

import Foundation

let fileURL = Bundle.main.url(forResource: "day7-input", withExtension: "txt")!
var instructions = Instructions()

let data = try! String(contentsOf: fileURL)
    .trimmingCharacters(in: .newlines)
    .split(separator: "\n")
    .forEach({ (instruction) in
        instructions.addInstruction(line: String(instruction))
    })

//print(instructions.steps)
print(instructions.executionOrder().joined())

//print(instructions.doWork(workers: 1, timeOffset: 0))
print(instructions.doWork(workers: 5, timeOffset: 60))

//: [Next](@next)
