import Foundation
import CoreImage

public struct Claim {
    let id: Int
    let rectangle: CGRect
}

extension Claim {
    public init(string: String) {
        // line format:
        // #3 @ 5,5: 2x2
        guard let matches: RegexMatch = Regex(pattern: "#(\\d+) @ (\\d+),(\\d+): (\\d+)x(\\d+)") ~= string else {
            fatalError()
        }
        self.id = Int(matches[1]!)!
        self.rectangle = .init(
            x: CGFloat(Int(matches[2]!)!),
            y: CGFloat(Int(matches[3]!)!),
            width: CGFloat(Int(matches[4]!)!),
            height: CGFloat(Int(matches[5]!)!)
        )
    }
}
