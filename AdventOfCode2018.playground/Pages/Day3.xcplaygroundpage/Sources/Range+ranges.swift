import Foundation

extension Range where Element: Hashable, Element: Comparable {
    static func ranges(from sequence: [Element]) -> [Range<Element>] {
        var oldX: Element?
        var ranges: [Range<Element>] = []
        for x in sequence.sorted() {
            if let oldX = oldX {
                ranges.append(oldX..<x)
            }
            oldX = x
        }
        
        return ranges
    }
}
