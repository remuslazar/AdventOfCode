import Foundation

public struct FreqChangeList {
    let list: [Int]
    
    public init(_ list: [Int]) {
        self.list = list
    }
    
    private var index = 0
    public private(set) var frequency = 0
    
    public mutating func advance() {
        frequency += currentStep
        index += 1
        if index == list.endIndex { index = 0 }
    }
    
    public var currentStep: Int {
        return list[index]
    }
    
}

public struct FreqProcessor {
    public let list: FreqChangeList
    
    public init(_ list: FreqChangeList) {
        self.list = list
    }

    public var firstAlreadySeenFrequency: Int {
        var knownFrequencies = Set<Int>()
        var list = self.list
        while !knownFrequencies.contains(list.frequency) {
            knownFrequencies.insert(list.frequency)
            list.advance()
//            if knownFrequencies.count > 3000 { break }
        }
        return list.frequency
    }
}
