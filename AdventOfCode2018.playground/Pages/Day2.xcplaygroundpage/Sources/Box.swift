import Foundation

public struct Box {
    public init(id: String) {
        self.id = id
    }
    
    private let id: String
}

extension Box {
    public func charsWhichOccurr(times: Int) -> Set<Character> {
        return Set(occurrencesOf.filter { $0.value == times }.map { $0.key })
    }
    
    private var occurrencesOf: [Character: Int] {
        var list: [Character: Int] = [:]
        id.forEach { (char) in
            list[char] = occurrences(of: char)
        }
        return list
    }
    
    private func occurrences(of character: Character) -> Int {
        return id.filter { $0 == character }.count
    }
}

extension Box {
    public func numberOfDifferingChars(comparing to: Box) -> Int {
        var diffCount = 0
        for index in id.indices {
            if self.id[index] != to.id[index] { diffCount += 1 }
        }
        return diffCount
    }
    
    public func nonDifferingChars(comparing to: Box) -> String {
        var chars = ""
        for index in id.indices {
            if self.id[index] == to.id[index] { chars += String(self.id[index]) }
        }
        return chars
    }
}

extension Box: CustomStringConvertible {
    public var description: String {
        return id
    }
}
