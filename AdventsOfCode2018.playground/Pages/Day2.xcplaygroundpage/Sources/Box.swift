import Foundation

public struct Box {
    public init(id: String) {
        self.id = id
    }
    
    public func charsWhichOccurr(times: Int) -> Set<Character> {
        return Set(occurrencesOf.filter { $0.value == times }.map { $0.key })
    }
    
    private let id: String
    
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
