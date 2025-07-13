# Handling Errors

If we don't handle errors, this can cause an app to crash at runtime. We can avoid this by:

Step 1: Define all errors that might happen in our code.
Step 2: Write functions that work as normal, but can throw functions to handle these error cases JIC.
Step 3: Try and run these functions, handling any errors.

As an example, we're going to write a function below that throws errors when a user's password is too simple or too predictable.

```swift
// Step 1: Defining the errors.
enum PasswordError: Error {
    case short, obvious
}

// Now we write a function that triggeres these errors.

func checkPassword(_ password: String) throws -> String { // Checkout the "throws" keyword
    if password.count < 5 {
        throw PasswordError.short
    } if password == "12345" {
        throw PasswordError.obvious
    }

    // Otherwise, do various checks.
    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }

}
```
Note the throws keyword – this allows a function to throw errors in Swift (it does not define an error), and it does not mean a function NEEDS to throw errors, just that it can. Our final step is to run the function, and handle these errors:

```swift
// We start a block of code that might through errors with the "do-try-catch" pattern.
do {
    try somethingRisky()
} catch {
    print("Handle errors here")
}

```
When an error occurs in the do block, it terminates that block and goes straight to the catch block. The "try" keyword must be written every time an error-prone function is called, and it also signals to other developers that the normal flow of code can stop.

You can add conditions for the catch blocks to filter out particular errors. For example:

```swift
let string = "12345"

do {
    let result = try checkPassword(string)
    print("Password rating: \(result)")
} catch PasswordError.short { // This condition causes this catch block to execute if this error is thrown.
    print("Please use a longer password.")
} catch PasswordError.obvious {
    print("I have the same combination on my luggage!")
} catch { // Catches all other errors.
    print("There was an error: \(error.localizedDescription)") // This is provided by Swift automatically.
}

```
Initialisers that throw can also propogate errors just like throwing functions. In the example below, init for struct PurchasedSnack calls a throwing function as part of the initialisation process, handling any errors by passing them through to its caller. The following code is for a vending machine.

```swift
// Defining errors that can be thrown.
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int) // this error returns an Int
    case outOfStock
}


// Setting up structs and class for example.
struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [ // dict with a string and the Item struct, allowing us to have references for a range of data that we can access using dot syntax.
        "Candy Bar": Item(price: 12, count: 7),
        "Crisps": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0

    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else { // Is the requested item in the inventory dict? if not, ->
            throw VendingMachineError.invalidSelection
        }

        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }

        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited) // This error (when defined) obviously returns Int coinsNeeded
        }

        coinsDeposited -= item.price // Subtract the price of the chosen item from the coinsDeposited variable.

        var newItem = item // This is because item is passed in as a constant.
        newItem.count -= 1 // Subtract amount vended from the count of newItem (which is the same as the item passed in)
        inventory[name] = newItem // Update the dict with the new stock count.

        print("Dispensing \(name)...")
    }
}


struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}
```
Importantly, if no catch blocks are able to pattern match with an error, what will happen is that the error will propogate to the surrounding scope until a suitable catch block catches the error. If the error reaches the top level without being handled, this will cause a Runtime Error.

You can also have multiple errors on a catch statement, separated by commas.

## Converting Errors to Optionals

A concise way to handle errors in a consistent way is to convert them to optionals using the **try?** keyword. If an error is thrown in this case, the value of the expression is *nil*. Examine the code below.

```swift
func someThrowingFunction() throws -> Int {
    // ...
}

let x = try? someThrowingFunction() // If this throws an error, the value is nil (we know this because we've used the try? keyword).

let y: Int? // This is an Int? because someThrowingFunction() returns an integer. If it returned a String or some other type, it would be of type String/T?
do {
    y = try? someThrowingFunction()
} catch {
    y = nil
}
```
Below is an example of how this principle can be used to concisely handled errors. We'll try and fetch data in two ways, and use returning nil with optionals as a last resort.

```swift
func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}
```

## Typed Throws

There are cases when you know exactly what error will be thrown by a function (for example in a library where all cases are handled by said library, or if you're using an embedded system with limited resources – by defining exactly what error will be thrown you prevent Swift from needing heap allocation).

The **heap** is a shared pool of memory during runtime, with lots of space but slower to access/organise. The **stack** on the other hand is very quick to push and pop, but has limited space.

This is relevant because when Swift is unsure about the type of error, it has to allocate memory to the heap to dynamically store information.

```swift
// Regular throws - Swift doesn't know what error types to expect
func regularThrows() throws -> String {
    // Swift must prepare for ANY error type - requires heap allocation
    throw SomeError.unknown
}

// Typed throws - Swift knows exactly what to expect
func typedThrows() throws(NetworkError) -> String {
    // Swift can pre-allocate stack space for NetworkError only
    throw NetworkError.timeout
}
```
In this way, this allows for compile-time memory planning instead of runtime allocation. Here is another example of code that summarises ratings and uses an error type – because we've defined this, we can just throw .errorName instead of ErrorType.errorName.

```swift
enum StatisticsError: Error {
    case noRatings
    case invalidRating(Int)
}

func summarise(_ ratings: [Int]) throws(StatisticsError) {
    guard !ratings.isEmpty else { throw .noRatings } // Continue with this function if the ratings array is not empty, otherwise throw the .noRatings error.

    var counts = [1: 0, 2: 0, 3: 0] // Initialise an empty dict to count each rating.
    for rating in ratings {
        guard rating >= 1 && rating <= 3 else { throw .invalidRating(rating) }
        counts[rating]! += 1 // Dictionary lookups return optionals because the values can be empty, it is safe here because the dict was initialised with all valid keys.
    }

    // Output summary to terminal.
    print("* \(counts[1]!), ** \(counts[2]!), *** \(counts[3]!)")

}
```
Naturally, Swift checks that any nested throwing functions conform to the error types thrown by parent functions. Let's rewrite this with do-catch-try blocks.

```swift
let ratings = []

do throws(StatisticsError) {
    try(summarise(ratings))
} catch {
    switch error { // A local constant the error is bound to at runtime, because there is no pattern within the catch statement.
    case .noRatings:
        print("No ratings available.")
    case .invalidRating(let rating): // the summarise function iterates through an array, with each value assigned to rating. This assigns this same value to a constant, which is then passed into this case.
        print("Invalid rating: \(rating)")
    }
}
```

## Error Cleanup

Remember defer statements – they run after you exit a block of code? Use these to cleanup after an error is thrown (e.g. closing the programme, freeing up malloc memory). They occur in the *reverse* order that they are in their code (first in, last executed).

Here is an example of code that handles an error where code is missing by closing the programme.

```swift
func openFile(fileName: String) throws {
    if exists(fileName) {
        let file = open(fileName)
        defer {
            close(file)
        }
        while let fileName = try file.readLine() {
            // Do stuff with the file
        }
    // if block ends here, so the close() function runs.
    }
}
```