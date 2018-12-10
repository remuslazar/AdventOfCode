import Foundation

public struct Display {
    public var points: [Point]
    public init(points: [Point]) {
        self.points = points
    }
}

public struct Viewport {
    public let nw: Point.Position // top left
    public let se: Point.Position // bottom right
}

extension Display {
    public var viewport: Viewport {
        var current = Viewport(nw: .init(x: 0, y: 0), se: .init(x: 0, y: 0))
        points.forEach { (point) in
            current = Viewport(nw: .init(x: min(current.nw.x, point.position.x), y: min(current.nw.y, point.position.y)),
                               se: .init(x: max(current.se.x, point.position.x), y: max(current.se.y, point.position.y)))
        }
        return current
    }
}

public struct Size {
    public let width: Int
    public let height: Int
}

extension Viewport {
    public var size: Size {
        return Size(width: se.x - nw.x,
                    height: se.y - nw.y)
    }
}

extension Display {
    public func render(viewport: Viewport) {
        let size = viewport.size
        var canvas: [[Bool]] = .init(repeatElement(.init(repeatElement(false, count: size.width+1 )), count: size.height+1))
  
        points.forEach { (point) in
            let offsetX = point.position.x - viewport.nw.x
            let offsetY = point.position.y - viewport.nw.y
            canvas[offsetY][offsetX] = true
        }
        
        canvas.forEach { (line) in
            print(line
                .map { $0 ? "#" : " " }
                .joined())
        }
    }
}

extension Display {
    public mutating func move() {
        for index in 0..<points.endIndex {
            points[index] = points[index].after
        }
    }
}
