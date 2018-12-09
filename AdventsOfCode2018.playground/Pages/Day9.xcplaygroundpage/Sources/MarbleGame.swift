import Foundation

public struct MarbleGame {
    
    struct Marble {
        let number: Int
    }
    
    private var pool = MarblePool()
    private struct MarblePool {
        private var currentNumber = 0
        mutating func getNextMarble() -> Marble {
            let marble = Marble(number: currentNumber)
            currentNumber += 1
            return marble
        }
    }

    public init(numPlayers: Int) {
        self.numPlayers = numPlayers
        circle.append(pool.getNextMarble())
        currentMarbleIndex = 0
    }
    
    public mutating func advance() {
        let newMarble = pool.getNextMarble()
        // calculate the insertion point in the circle
        let newIndex = (currentMarbleIndex + 1) % circle.endIndex + 1
        // it is ok for newIndex to be equal circle.endIndex. In this case, the new element will be appended to the array
        circle.insert(newMarble, at: newIndex)
        currentMarbleIndex = newIndex
        nextPlayer()
    }
    
    var currentMarble: Marble {
        return circle[currentMarbleIndex]
    }
    
    private var circle: [Marble] = []
    private var currentMarbleIndex: Int
    private let numPlayers: Int
    public var currentPlayer: Int?
    
    private mutating func nextPlayer() {
        // player number starts at 1 and *not* 0
        currentPlayer = currentPlayer == nil ? 1 : currentPlayer! + 1
        if currentPlayer! > numPlayers {
            currentPlayer = 1
        }
    }

}

extension MarbleGame: CustomStringConvertible {
    public var description: String {
        return "[\(currentPlayer != nil ? String(currentPlayer!) : "-")] "
            + circle.enumerated()
                .map {
                    if $0.offset == currentMarbleIndex {
                        return "(\($0.element.number))"
                    } else {
                        return " \($0.element.number) "
                    }
                }
                .joined(separator: " ")
    }
}
