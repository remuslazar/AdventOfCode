import Foundation

/// Data Structure of a point.
public struct Point {
    public struct Position {
        let x: Int // how far left (negative) or right (positive)
        let y: Int // how far up (negative) or down (positive)
        init(x: Int, y: Int) {
            self.x = x
            self.y = y
        }
    }
    public struct Velocity {
        // Each second, each point's velocity is added to its position
        let dx: Int
        let dy: Int
    }
    public let position: Position // current position
    public let velocity: Velocity // velocity
    
    var after: Point {
        let newPosition = Position(x: position.x + velocity.dx,
                                   y: position.y + velocity.dy)
        return Point(position: newPosition, velocity: self.velocity)
    }
    
}

extension Point {
    /// Initialize a Point from a string definition
    ///
    /// - Parameter string: e.g. "position=< 1,  8> velocity=< 1, -1>"
    public init(string: String) {
        guard let matches: RegexMatch = Regex(pattern: "position=<\\s*(.+?),\\s*(.+?)> velocity=<\\s*(.+?),\\s*(.+?)>") ~= string else {
            fatalError()
        }
        position = .init(x: Int(matches[1]!)!, y: Int(matches[2]!)!)
        velocity = .init(dx: Int(matches[3]!)!, dy: Int(matches[4]!)!)
    }
}

extension Point: CustomStringConvertible {
    public var description: String {
        return "p: \(position.x),\(position.y), v: \(velocity.dx),\(velocity.dy)"
    }
}
