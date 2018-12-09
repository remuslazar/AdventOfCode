import Foundation

public struct MarbleGame {
    
    struct Marble {
        let number: Int
    }
    
    struct Player {
        var score = 0
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
        players = (0..<numPlayers).map { Player(score: 0, number: $0 + 1) }
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
    private let players: [Player]
    private var currentPlayerIndex: Int?
    
    private mutating func nextPlayer() {
        guard var currentPlayerIndex = currentPlayerIndex else {
            self.currentPlayerIndex = 0
            return
        }
        currentPlayerIndex += 1
        if currentPlayerIndex == players.endIndex {
            currentPlayerIndex = 0
        }
        self.currentPlayerIndex = currentPlayerIndex
    }
    
    var currentPlayer: Player? {
        guard let index = currentPlayerIndex else { return nil }
        return players[index]
    }

}

extension MarbleGame: CustomStringConvertible {
    public var description: String {
        return "[\(currentPlayer != nil ? String(currentPlayer!.number) : "-")] "
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
