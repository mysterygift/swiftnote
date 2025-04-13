# Control Transfer Statements

Change the order of code execution. They include:

* continue
* break
* fallthrough
* return (described in functions.md)
* throw (described in errors.md or some similar file – not written those notes yet!)

# Continue

Used to tell a loop to stop and then start the next iteration of the loop. This example removes all whitespace and vowels from a phrase and then outputs a string.

```swift
let inputPhrase = "it is what it is"
var outputPhrase = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
for character in inputPhrase {
    if charactersToRemove.countains(character) {
        continue
    }
    outputPhrase.append(character)
}
print(outputPhrase) // prints "tswhtts"
```

# Break

Ends a control statement immediately. In loop statements, this transferse control to the code following the closing } of a loop. Does the same for switch statements. Handy if you have a switch case you want to ignore, which is a good idea if you have to deliberately match a case to ignore to make intentions clear.

If you do not have a default case for a switch statement, you must put a break in there.

Switch does not have fallthrough where when a case is complete it progresses to the next one. The statement is completed as soon as the first match is found. If you need fallthrough behaviour you can state this by:

```swift
let intToDescribe = 5
var description = "The number \(intToDescribe) is"
switch intToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number and also"
    fallthrough
default:
    description += "an integer."
}
```

NB! Fallthrough does NOT check the condition of subsequent case blocks, it just executes the code inside the case.

# Labelled Statements

When you nest loops or other conditional statements you can use labels to make the loop or conditional statement you want to terminate explicit. Labelled conditionals can use a statement label with break to end the execution of a labelled statement, whereas labelled loops can use statement labels to either break or continue the execution of a labelled statement. See the example below.

```swift
<#label name#> : while <#condition#> {
    <#statements>
}
```

We're going to replicate Snakes and Ladders again, except this time with the added rule that in order to win you must land EXACTLY on square 25. If your roll would take you beyond this square you must re-roll.

```swift

func rollDice() -> {
    return Int.random(in: 1...6)
}

let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1) // Remember we add 1 to this because arrays are zero-indexed.
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02 // Adding the snakes and ladders and determining where on the board you get moved.
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08  // More SnL.

var square = 0
var diceRoll = 0

// We're going to use a while loop and switch statement for the game logic. The while loop will include a statement label called "gameLoop". The condition for this loop will be while square != finalSquare (because the game will continue until the player lands on the final square).

gameLoop: while square != finalSquare {
    diceRoll = rollDice()
    switch square + diceRoll { // A switch statement where these two variables are added together and then it iterates through each case.
    case finalSquare:
        // diceRoll moves us to the final square so the game ends.
        break gameLoop // Breaks THIS specific loop (gameLoop)
    case let newSquare where newSquare > finalSquare: // defines a temp constant within the scope of this statement and checks to see if the result of the switch's conditional is less than the value stored in finalSquare.
        // dR will move us beyond the final square, so roll again.
        continue gameLoop
    default: // You must always provide default cases. In this case the move is valid, so it finds out it's effect.
        square += diceRoll // Add the value of the diceRoll.
        square += board[square] // Checks the board array to see if there are any modifiers, and adds/subtracts them from the value stored in square.
    }
}
print("Game over!")

```

# Early Exit

Guard statements execute depending on the value of an expression. You use them to require conditionals to return true in order for the code to execute. Unlike if statements, guard statements ALWAYS have else clauses.

Guard statements MUST be inside either a function, a method or a closure.

These improve code readability as you can write code that's the expected outcome without wrapping it in an else block, and you can keep code that handles violated requirements right next to it. Below is an example of an implementation:

```swift
func greet(person: [String: String]) { // Expects a dict where both values are strings and assigns them to the temp variable "person".
    guard let name = person["name"]
    else { // "name" is being referred to here as one of the kv pairs of this dict, and sets that equal to a variable called "name"...
        return
    }

    print("Hello \(name)!") // ...which is then used here.

    guard let location = person["location"]
    else {
        print ("I hope the weather is nice near you.")
        return
    }

    print("I hope the weather is nice in \(location)")
}

greet(person: ["name" : "John"]) // Prints "Hello John!" "I hope the weather is nice near you."
greet(person: ["name" : "Jane", "location" : "Cupertino"]) // Prints "Hello Jane!" "I hope the weather is nice in Cupertino."
```

You don't necessarily have to use return either for else statements, you can use anything that doesn't return a value (e.g. return, break, continue, throw or call funcs/methods that don't return such as fatalError(_:file:line)).

# Deferred Actions

Defer controls WHEN a piece of code is executed (e.g. write code that is executed later, such as when the programme reaches the end of the current scope).

```swift
var score = 1
if score < 10 {
    defer {
        print(score)
    }
    score +=5
} // Prints "6".
```

If you have multiple defer statements the first one specified is the last to run.

NB: Deferred code executes after errors are thrown.