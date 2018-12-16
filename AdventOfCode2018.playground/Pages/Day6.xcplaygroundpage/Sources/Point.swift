import Foundation

public struct Point {
    public let x: Int
    public let y: Int
    
    public init(line: Substring) {
        let coords = line
            .split(separator: ",")
            .map { String($0).trimmingCharacters(in: .whitespaces) }
        x = Int(coords[0])!
        y = Int(coords[1])!
    }
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

extension Point: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

public extension Point {
    public func taxicabDistance(from other: Point) -> Int {
        return abs(self.x-other.x) + abs(self.y-other.y)
    }
}

extension Point: CustomStringConvertible {
    public var description: String {
        return "(\(x),\(y))"
    }
}
