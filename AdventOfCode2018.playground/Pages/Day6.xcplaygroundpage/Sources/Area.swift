import Foundation

public struct Area {
    let x: ClosedRange<Int>
    let y: ClosedRange<Int>

    private var chunks: [[Bool]]
    
    public init(x: ClosedRange<Int>, y: ClosedRange<Int>) {
        self.x = x
        self.y = y
        self.chunks = [[Bool]].init(repeating: [Bool].init(repeating: true, count: x.count), count: y.count)
    }

    public var area: Int {
        var retVal = 0
        // TODO: refactor it using e.g. reduce
        chunks.forEach { (line) in
            line.forEach { (isIncluded) in
                if isIncluded { retVal += 1 }
            }
        }
        return retVal
    }
}

// Use our Point data structure for convenience
public extension Area {
    public init(points: Set<Point>) {
        let xCoords = points.map { $0.x }.min()!...points.map { $0.x }.max()!
        let yCoords = points.map { $0.y }.min()!...points.map { $0.y }.max()!
        self.init(x: xCoords, y: yCoords)
    }
    
    public mutating func exclude(point: Point) {
        let xIndex = point.x-x.lowerBound
        let yIndex = point.y-y.lowerBound
        chunks[yIndex][xIndex] = false
    }

    public var coordinates: [Point] {
        var retVal: [Point] = []
        x.forEach { (x) in
            y.forEach { (y) in
                retVal.append(Point(x: x, y: y))
            }
        }
        return retVal
    }
    
    public func has(point: Point) -> Bool {
        let xIndex = point.x-x.lowerBound
        let yIndex = point.y-y.lowerBound
        return chunks[yIndex][xIndex]
    }
}

extension Area: CustomStringConvertible {
    public var description: String {
        return "x: \(x), y: \(y), size: \(x.count)x\(y.count)"
    }
}

public extension Area {
    public func render() {
        chunks.forEach { (line) in
            let lineString = line.map{ $0 ? "x" : "." }.joined()
            print(lineString)
        }
    }
}
