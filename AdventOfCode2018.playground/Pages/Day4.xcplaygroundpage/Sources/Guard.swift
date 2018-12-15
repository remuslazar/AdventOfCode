import Foundation

public struct GuardSleepEntry {
    public let id: Int
    // midnight hour asleep range (minutes)
    public let asleepRange: Range<Int>
}

public struct GuardSleepTable {
    public let asleep: [GuardSleepEntry]
}

extension GuardSleepEntry: CustomStringConvertible {
    public var description: String {
        return "#\(id) asleep: \(asleepRange.lowerBound)..\(asleepRange.upperBound-1)"
    }
}

extension GuardSleepEntry {
    var sleepMinutes: Int {
        return asleepRange.upperBound-asleepRange.lowerBound
    }
}

public extension GuardSleepTable {
    public func asleepMinutes(guardID: Int) -> Int {
        return asleep.filter { $0.id == guardID }.map { $0.sleepMinutes }.reduce(0, +)
    }
    public var guardIDs: Set<Int> {
        return Set(asleep.map { $0.id })
    }
    public func asleepRanges(guardID: Int) -> [Range<Int>] {
        return asleep.filter { $0.id == guardID }.map { $0.asleepRange }
    }
}

public extension GuardSleepTable {
    init(input: [String]) {
        // [1518-03-28 00:04] Guard #2663 begins shift
        // [1518-11-03 00:22] falls asleep
        // [1518-10-14 00:57] wakes up

        var guardID: Int?
        var asleepMinute: Int?
        var asleepTable: [GuardSleepEntry] = []
        
        input.sorted().forEach { (line) in
            guard let matches: RegexMatch = Regex(pattern: "\\[\\d{4}-\\d{2}-\\d{2} (\\d{2}):(\\d{2})\\] (.+)") ~= line else {
                fatalError("parse error")
            }
            let _ = Int(matches[1]!)
            let minute = Int(matches[2]!)
            let action = matches[3]!
            
            if let matches: RegexMatch = Regex(pattern: "Guard #(\\d+) begins shift") ~= action {
                guardID = Int(matches[1]!)
                
            } else if action == "falls asleep" {
                asleepMinute = minute
            } else if action == "wakes up" {
                asleepTable.append(GuardSleepEntry(id: guardID!, asleepRange: asleepMinute!..<minute!))
            }
            
        }
        
        asleep = asleepTable
    }
}
