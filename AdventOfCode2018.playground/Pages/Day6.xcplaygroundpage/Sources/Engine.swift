import Foundation

public struct Engine {

    static public func calculateLargestArea(for points: Set<Point>) -> Int {
        
        let distances: [Int] = points.map { (point) in
            var area = Area(points: points)

            var otherpoints = points
            otherpoints.remove(point)
            
            guard point.isInside(points: otherpoints) else { return Int.min }
            
            otherpoints.forEach { (otherPoint) in
                area.coordinates.forEach { (coordinate) in
                    let myDistance = coordinate.taxicabDistance(from: point)
                    let otherDistance = coordinate.taxicabDistance(from: otherPoint)
                    if otherDistance <= myDistance {
                        area.exclude(point: coordinate)
                    }
                }
            }
            guard area.isFinite else { return Int.min }
            
            print("Point: \(point), area: \(area.area)")
            return area.area
        }
        return distances.max()!
    }

}

/*:
 nw | ne
 -------
 sw | se
 */
enum Position {
    case nw
    case ne
    case se
    case sw
    case same
}

extension Point {
    
    /// Position other point regarding self
    func position(of otherpoint: Point) -> Position {
        guard otherpoint.x != self.x else { return .same }
        guard otherpoint.y != self.y else { return .same }

        return otherpoint.y < self.y ?
            (otherpoint.x < self.x ? .nw : .ne) :
            (otherpoint.x < self.x ? .sw : .se)
    }
    
    func isInside(points: Set<Point>) -> Bool {
        var positions = Set<Position>()
        points.forEach { (point) in
            positions.insert(self.position(of: point))
        }
        return positions.contains(.nw)
            && positions.contains(.ne)
            && positions.contains(.se)
            && positions.contains(.sw)
    }
}

private extension Area {
    var isFinite: Bool {
        let shape = self.coordinates.filter { self.has(point: $0) }
        return shape.map { $0.x }.min()! > self.x.lowerBound
            && shape.map { $0.x }.max()! < self.x.upperBound
            && shape.map { $0.y }.min()! > self.y.lowerBound
            && shape.map { $0.y }.max()! < self.y.upperBound
    }
}
