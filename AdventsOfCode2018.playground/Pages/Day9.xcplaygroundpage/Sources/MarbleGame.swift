import Foundation

public struct MarbleGame {
    
    struct Marble {
        let number: Int
    }
    
    class Player {
        var score = 0
        let number: Int
        init(number: Int) {
            self.number = number
        }
    }
    
    private var pool: MarblePool

    private struct MarblePool {
        private var currentNumber = 0
        private let maxMarbleNumber: Int
        mutating func getNextMarble() -> Marble? {
            guard currentNumber <= maxMarbleNumber else {
                return nil
            }
            let marble = Marble(number: currentNumber)
            currentNumber += 1
            return marble
        }
        init(_ maxMarbleNumber: Int) {
            self.maxMarbleNumber = maxMarbleNumber
        }
    }

    public init(numPlayers: Int, lastMarble: Int) {
        players = (1...numPlayers).map { Player(number: $0) }
        pool = MarblePool(lastMarble)
        board = CircularArray<Marble>(rootElement: pool.getNextMarble()!)
    }
    
    public mutating func advance() -> Bool {
        guard let newMarble = pool.getNextMarble() else {
            return false
        }
        
        if newMarble.number % 23 != 0 {
            // calculate the insertion point in the circle
            board.insert(newMarble, after: 1)
        } else {
            // However, if the marble that is about to be placed has a number which is a multiple of 23, something entirely different happens.
            guard let currentPlayer = currentPlayer else { fatalError("no current player") }
            currentPlayer.score += newMarble.number
            let marble = board.remove(at: -7)
            currentPlayer.score += marble.number
        }

        nextPlayer()
        return true
    }
    
    public mutating func playGame() {
        while advance() { }
    }
    
    var currentMarble: Marble {
        return board.current
    }
    
    private var board: CircularArray<Marble>
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
    
    public var scoreTable: String {
        return players.map { $0.description }.joined(separator: "\n")
    }
    
    public var bestScore: Int {
        return players.sorted().last!.score
    }

}

extension MarbleGame: CustomStringConvertible {
    public var description: String {
        return "[\(currentPlayer != nil ? String(currentPlayer!.number) : "-")] \(board)"
    }
}

extension MarbleGame.Player: CustomStringConvertible {
    var description: String {
        return "Player \(self.number), Score: \(self.score)"
    }
}

extension MarbleGame.Marble: CustomStringConvertible {
    var description: String {
        return "\(self.number)"
    }
}

extension MarbleGame.Player: Comparable {
    static func < (lhs: MarbleGame.Player, rhs: MarbleGame.Player) -> Bool {
        return lhs.score < rhs.score
    }
    static func == (lhs: MarbleGame.Player, rhs: MarbleGame.Player) -> Bool {
        return lhs.number == rhs.number
    }
}
