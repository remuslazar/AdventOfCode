import Foundation

public struct Claim {
    let id: Int
    let x: Int // 0 > left
    let y: Int // 0 > top
    let width: Int
    let height: Int
}

extension Claim {
    public init(string: String) {
        // line format:
        // #3 @ 5,5: 2x2
        guard let matches: RegexMatch = Regex(pattern: "#(\\d+) @ (\\d+),(\\d+): (\\d+)x(\\d+)") ~= string else {
            fatalError()
        }
        self.id = Int(matches[1]!)!
        self.x = Int(matches[2]!)!
        self.y = Int(matches[3]!)!
        self.width = Int(matches[4]!)!
        self.height = Int(matches[5]!)!
    }
}

extension Claim: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

extension Claim {
    var minX: Int { return x }
    var maxX: Int { return x + width }
    var minY: Int { return y }
    var maxY: Int { return y + height }
}

extension Claim {
    func contains(yRange: Range<Int>) -> Bool {
        return yRange.lowerBound >= minY && yRange.upperBound <= maxY
    }
    func contains(xRange: Range<Int>) -> Bool {
        return xRange.lowerBound >= minX && xRange.upperBound <= maxX
    }
}
