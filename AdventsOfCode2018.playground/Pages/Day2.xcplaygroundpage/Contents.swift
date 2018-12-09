//: [Previous](@previous)

import Foundation

let fileURL = Bundle.main.url(forResource: "day2-input", withExtension: "txt")!

let data = try! String(contentsOf: fileURL)
let boxIDs = data
    .split(separator: "\n")

let boxes = boxIDs.map { Box(id: String($0)) }

let numOfBoxesWith2Chars = boxes.filter { $0.charsWhichOccurr(times: 2).count >= 1 }.count
let numOfBoxesWith3Chars = boxes.filter { $0.charsWhichOccurr(times: 3).count >= 1 }.count

numOfBoxesWith2Chars * numOfBoxesWith3Chars

//: [Next](@next)
