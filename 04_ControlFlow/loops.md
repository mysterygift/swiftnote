# For-In Loops

Used for any sequence of values (can be in a collection, can be in a range of numbers, or characters in a string (which is technically an array of chars)).

```swift
let array = Array[repeating: Int, count: 10]
for item in array {
    print("Hey, \(item).")
}
```

As mentioned in [dicts.md](../03_Collections/dicts.md) you can also iterate through kv pairs in a dict. For example:

```swift
let arrivals = ["1600": "London Heathrow", "1605": "Tokyo Hanada", "1715": "Don Mueang International", "1724": "Phuket International"]
for (flightTime, departureLocation) in arrivals {
    let formattedTime = String(flightTime.prefix(2) + ":" + String(flightTime.suffix(2)))
    print("The \(formattedTime) flight from \(depatureLocation) has now landed.")
}
```
We can also use the "where" keyword to add specific conditions when iterating through a for-in loop.

When iterating through ranges of numbers:

```swift
for index in 1...5 { // The closed range operator (...) is inclusive.
    print("\(index) times 5 is \(index * 5)")
}
```

There are some instances where we don't need each value from a sequence. In that case, we can use an underscore in place of a variable name.
In the example below, we multiply the base by itself the number of times provided by the exponent. The closed range operator does it for us.

```swift
let base = 3
let exponent = 8
var answer = 1

for _ in 1...exponent { // The use of the underscore here stops the value of each iteration being returned (presumably some performance improvements here?)
    answer *= base
}
```
Actually while we're here let's look at ranged ops.

We also have the "half-open" range operator, defining a value that runs from X up to but not including Y. See below.

```swift
for index in 1..<5 { // The closed range operator (...) is inclusive.
    print("\(index)\n")
}
// 1 2 3 4
```

Lastly we have "one-sided" ranges for values that continue as far as possible in one direction e.g. from index 3 to the end of an array
myArray[3...], or up to the 8th item in an array myOtherArray[...8]. You can also use half-open arrays with this.

Importantly, we can use these beyond subscripts. You CANNOT iterate over a one-sided range that omits its first value as it's unclear where the iteration starts. You can iterate over a one-sided range without an ending as long as you provide some sort of explicit end condition for the loop (otherwise it will repeat endlessly).

# While Loops

Repeats until a condition becomes false. "while" checks the condition at the start of each loop, "repeat-while" checks at the end.

```swift
while <#condition#> {
    <#statements#>
}
```

Here is an example of how while loops can be used in conjunction with arrays to represent Snakes & Ladders.

```swift
// Imagine a 5 by 5 board. We don't need to worry about the pattern on the board, just which squares have ladders or snakes.
// We represent the board using an array of 25 Ints, with the number at each index representing any modifiers to player position (do they move up or down the board in the event there is a snake/ladder)

// Start by defining the rollDice() function.
func rollDice() -> {
    return Int.random(in: 1...6)
}

let finalSquare = 25 // This is the win condition of the game.
var board = [Int](repeating: 0, count: finalSquare + 1) // Arrays are 0-indexed, therefore we have an extra square.

board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02 // Ladders – we used the unary plus (+i) operator here to align the values & statements.
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08 // Snakes

var playerPos = 0
var diceRoll = 0
var turnCounter = 0

while playerPos < finalSquare {
    diceRoll = rollDice()
    playerPos = playerPos + diceRoll
    turnCounter += 1
    if playerPos < finalSquare {
        playerPos += board[playerPos]
        print("Current position is \(playerPos).")
    }
}

print("Game over!")

```

Because it's unclear how many iterations of the loop will be needed to complete the game, a while loop is appropriate.

# Repeat-While Loops

Go through block first, before checking condition to repeat the loop.

```swift
repeat {
    <#statements#>
} while <#conditions#>
```

This would have been more appropriate than a while loop as it removes the need for an array bounds check.

```swift
repeat {
    playerPos += board[playerPos]
    diceRoll = rollDice()
    playerPos += diceRoll
} while playerPos < finalSquare
```