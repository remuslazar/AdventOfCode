import Foundation

public struct Polymer {
    let data: String

    public init(data: String) {
        self.data = data
    }

    public func react()-> Polymer {
        // todo: implementation
    }
    
}

extension Polymer: CustomStringConvertible {
    public var description: String {
        return "units: \(data)"
    }
}
