import Foundation

public struct Polymer {
    let units: String

    public init(data: String) {
        self.units = data
    }

    public func react() -> Polymer {
        var units = self.units

        func react() -> Bool {
            var rangesToRemove: [Range<String.Index>] = []

            var index = units.startIndex
            while index < units.endIndex {
                let nextIndex = units.index(after: index)
                guard nextIndex < units.endIndex else { break }

                let unit = units[index]
                let nextUnit = units[nextIndex]

                if unit.lowercased() == nextUnit.lowercased(), unit != nextUnit {
                    let nextIndex = units.index(index, offsetBy: 2)
                    rangesToRemove.append(index..<nextIndex)
                    index = nextIndex
                } else {
                    index = nextIndex
                }
            }

            guard !rangesToRemove.isEmpty else { return false }
            
            for range in rangesToRemove {
                units.replaceSubrange(range, with: "  ")
            }
            units = units.replacingOccurrences(of: "  ", with: "")

            return true
        }

        while react() { }
    
        return Polymer(data: units)
    }
}

extension Polymer: CustomStringConvertible {
    public var description: String {
        return "units: \(units)"
    }
}

extension Character {
    func lowercased() -> Character {
        return Character(String(self).lowercased())
    }
    func uppercased() -> Character {
        return Character(String(self).uppercased())
    }
}

public extension Polymer {
    public var length: Int {
        return units.count
    }
}

public extension Polymer {

    /// all units available in the polymer, lowercased
    public var allUnits: Set<Character> {
        var allUnits = Set<Character>()
        units.forEach { allUnits.insert($0.lowercased()) }
        return allUnits
    }

    public func polymerByRemoving(unit: Character) -> Polymer {
        return Polymer(data: self.units
            .replacingOccurrences(of: String(unit), with: "")
            .replacingOccurrences(of: String(unit.uppercased()), with: "")
        )
    }
}
