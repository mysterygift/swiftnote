import Cocoa
import Foundation

func rollDice() -> Int {
    return Int.random(in: 1...6)
}

let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)

board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

var playerPos = 0
var diceRoll = 0
var turnCounter = 0
while playerPos < finalSquare {
    diceRoll = rollDice()
    playerPos = playerPos + diceRoll
    turnCounter += 1
    if playerPos < finalSquare {
        playerPos = playerPos + board[playerPos]
        print("Current position is \(playerPos).")
    }
}

print("Game over!")
