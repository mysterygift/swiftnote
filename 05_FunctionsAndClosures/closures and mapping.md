# Closures

Group code that executes together without making a named function. They can be passed around and used in your code. They are similar to lambda functions.

Closures capture and store references to consts/vars from how they're defined – "closing over" those constants and variables.

Closures are one of these three forms:

* Global funcs are closures that have a name and don't capture any values.
* Nested funcs are closures that have a name and can capture values from their enclosing function.
* Closure expressions have no name, written in lightweight syntax that can capture surrounding values.

They infer parameter and return value types from context, have implicit returns from single-expression closures, have shorthand arg names, and have "trailing closure syntax".

## Closure Expressions & sorted(by:)

Nested functions are conveninent means of naming/defining self-contained blocks of code as part of a larger enclosing function. That said it's often useful to write shorter function-like code w/out a full declaration and name (esp when passing functions as an argument).

We'll use sorted(by:) (included in the Swift standard library) to demonstrate this.

sorted(by:) returns a sorted array of values of a known type based on a provided sorted closure. The returned array will be of the same size and type as the old one. Here's an example of how we can sort an array of strings into reverse alphabetical order.

The sorted(by:) method acceps a closure that takes two args of the same type as the array's contents, and returns a Bool to say if the first or second value should appear once the values are sorted (Bool to return false if the 2nd value appears first).

```swift
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

// The sorting closure must be of type (String, String) -> Bool as we're sorting an array of strings.
// We can pass the function as an argument to sorted(by:)

func reverseAlphabetical(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

var reversedNames = names.sorted(by: reverseAlphabetical)

```

Looking at the body of reverseAlphabetical(), if the value of s1 is greater than the value of s2, the function will return true, showing that s1 should appear before s2. B is greater than A (the unicode value of the character B is great than the unicode value of A).

This is a lot for just a single-expression function, so let's use an in-line closure.

## Closure Expression Syntax

```swift
{ (<#parameters#>) -> <#return type#> in
    <#statements#>
} // General form of closure expression syntax.
```

Parameters in closures can be inouts, but they CANNOT have default values. You can use variadics if you name the parameters. You can also have tuples as parameters/return types.

If we rewrite the reverseAlphabetical() as an inline closure:

```swift
reversedNames = names.sorted(by: { s1: String, s2: String -> Bool in return s1 > s2 })
```

Using type inference, we can minimise the syntax to omit the parameter and return types – meaning you never need to write these when passing a closure to a method or function.

```swift
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 })
```

Because the function type of sorted(by:) makes it clear that it needs a Bool returned we can remove "return" from the above. This is the case with single-expression closures.

## Shorthand Args, .map and .compactMap

You just increase the number next to $ depending on the number of args ($0, $1, $2, $3 etc)

```swift
reversedNames = names.sorted(by: { $1 > $0 })
```

You can even use operator methods here as they're all actually functions. > returns the same type for string comparison as the sorted(by:) method expects, so the following is valid and very idiomatic Swift code.

```swift
reversedNames = names.sorted(by: >)
```

We can also use the .map(_:) method to apply an expression to each item of a collection, returning a new array. It can also return a different type to the one passed in (e.g. converting ints to strings).

```swift
var team = ["John", "Sally", "Arlo", "Finn", "Ash"]

let uppercasedTeam = team.map { $0.uppercased() }
print(uppercasedTeam)
// Prints ["JOHN", "SALLY", "ARLO", "FINN", "ASH"]
```

Let's say we have an array of integers that we want to convert into strings. That can be done by:

```swift
let numbers = [1, 2, 3, 4, 5]
let stringNumbers = numbers.map { String($0) }
print(stringNumbers)
// Prints ["1", "2", "3", "4", "5"]
```

But what if we wanted to do this the other way around? It's a bit more complicated because the Int() intialiser returns Int? (optional) because not all strings can be converted to valid integers. We would have to use either default values for invalid ints *{ Int($0) ?? -1#or another default value# }*, or use nil-coallescing to handle it *{ Int($0) ?? 0 }*.

*.compactMap automatically removes nils and unwraps optionals.* It combines mapping with basic filtering. See below.

```swift
let unsortedData = ["1", "5", "Hello", "uwu", "93", "32"]
let cleanedData = unsortedData.compactMap { Int($0) }.sorted() // You can append several methods as well!
print(cleanedData) // Prints [1, 5, 32, 93]
```

Below are some examples of development use cases that I have annotated.

```swift
// Filtering and transforming an API response.

struct User {
    let id: Int
    let name: String?
    let email: String?
}

let users = [
    User(id: 1, name: "Alice", email: "alice@example.com"),
    User(id: 2, name: nil, email: "bob@example.com"),
    User(id: 3, name: "Charlie", email: nil)
]

// Fetch users with only valid names.
let usersWithNames = users.compactMap { $0.name }
print(usersWithNames) // ["Alice", "Charlie"].

// Fetch users with both names AND emails.
let completeUsers = users.compactMap { $0 -> User? in // For each entry in the users array, return an optional User struct. "in" separates declaration from implementation.
    guard let name = $0.name, let email = $0.email else { return nil }
    return User(id: $0.id, name: name, email: email)
}

// Parsing JSON data where their may be fields missing. I've added context for getting this to appear in a view in Swift UI.

struct Product {
    let name: String
    let price: Int
}

struct ProductListView: View {
    @State private var products: [Product] = []

    var body: some view {
        NavigationView {
            List(products) { product in // This applies the following to each item in the products array. product could have also been $0.
                HStack { // Stack these horizontally.
                    Text(product.name) // The name of the product (accessed with dot syntax).
                    Spacer() // A dynamic spacer.
                    Text("£\(product.price)") // The price of the product.
                }
            }
        }
        .navigationTitle("Products")
    }
    .onAppear { loadProducts() }

    func loadProducts() {
    let jsonArray: [[String: Any]] = [
        ["name": "iPhone", "price": 999],
        ["name": "iPad"], // Missing price
        ["price": 599],   // Missing name
        ["name": "MacBook", "price": 1299]
    ]

    let validProducts = jsonArray.compactMap { dict -> Product? in
        guard let name = dict["name"] as? String,
            let price = dict["price"] as? Int else {
            return nil
        }
        return Product(name: name, price: price)
    }
    }
}
```

Lastly, if is also common to chain .compactMap with other higher-order functions (like .filter or another .map).

```swift
struct NumberProcessorView: View {
    @state private var processedNumbers: [Int] = []

    let numbers = ["1", "2", "4", "5", "Hello", "8", "7", "13"]

    var body: some View {
        VStack {
            Text("Processed: \(processedNumbers.map(String.init).joined(separator: ", "))") // String.init is a ref to the string initiliaser function, it is the same as {.number in String(number) } but more concise and readable.

            Button("Process Numbers") {
                processedNumbers = numbers
                .compactMap { Int($0) } // Convert to int and filter out invalid entries/unwrap optionals.
                .filter { $0 % 2 == 0 } // Filter out odd numbers.
                .map { $0 * $0 } // Square them.
            }
        }
        .padding()
    }
}
```

## Trailing Closures

Generally used when the closure is too long to write inline.

Say you want to pass a closure to a function as its final argument, you can write it as a trailing closure instead (after the functions "}"). When using trailing closure syntax, you don't write the argument label for the 1st closure as part of the function call. Functions can have multiple trailing closures.

```swift

// First examples does NOT use TCs.

func closureFunc(closure: () ->) {
    // function body
}

closureFunc(closure: {
    // closure body here
})

// Using TCs

closureFunc() {
    // trailing closure body here
}

```

Trailing closure syntax allows you to write cleaner code when you pass a closure as the last arg in a function. You can omit parameter labels and write the closure outside the function's (). If the closure is the only parameter, you can totally omit the (). Below is an example using .sorted() with a filter.

```swift
// No trailing closure:
let sortedNumbers = numbers.sorted(by: { $0 < $1 })

// With trailing closure:
let moreSortedNumbers = numbers.sorted { $0 < $1 }
```

If a function takes multiple closures, you omit the arg label for the first TC and then label the remaining TCs. Here's an example of a function that laods a picture from a photo gallery:

```swift
func loadPicture(from server: Server, completion: (Picture) -> Void, onFailure: () -> Void) { // We pass two closures here!
    if let picture = download("photo.jpg", from: server) {
        completion(picture)
    } else {
        onFailure()
    }
}
```

We've passed two closures into loadPicture() – the first being a "completion handler" that displays a picture after a successful download, the second being an error handler that displays an error to the user.

```swift
loadPicture(from: someServer) { picture in
    someView.currentPicture = picture // Completion handler which runs when the download succeeds, updates the UI.
} onFailure: {
    print("Couldn't download the next picture, dawg") // Error handler, what do you do if the DL fails?
}
```

That said, completion handlers can become hard to read and can lead to memory issues/callback "hell". Concurrency is a cleaner option, and will be discusssed in concurrency.md.

## Capturing Values

Closures can capture consts/vars from surrounding context, referring to and modifying those consts/vars within itself even after the scope that defined those consts/vars no longer exists. Nested functions are examples of closures that can capture any of its outer function's args, consts or vars.

The below example has a nested func that captures two values: runningTotal and amount. The func then returns the nested func as a closure that does its thing each time it's called.

```swift
func makeIncrementer(forIncrement amount: Int) -> () -> Int { // This func returns () -> Int <a function!>
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount // Captured from the enclosing function.
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10) // This constant now refers to the incrementer function, adding to the runningTotal variable each time it's called.

incrementByTen() // returns 10
incrementByTen() // returns 20
incrementByTen() // returns 30
```

But why do this? If you looked at incrementer() in isolation it would look a bit weird, with no parameters but returning a variable and amount from within its body. This function captures a REFERENCE to runningTotal and amount from the enclosing function, ensuring that rT and amount don't disappear when the call to makeIncrementer ends (keeping rT available next time incrementer() is called).

Swift handles memory management of any unmutated copies of data used by closures if the value isn't mutated after a closure is called. There's also waste management geetting rid of unneeded vars.

Let's say we wanted to repurpose the incrementer to have a different amount – we can assign a constant to it which will have its own *separate* runningTotal variable:

```swift
let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven() // returns 7
```

If you assign a closure to a property of a class instance, the closure captures that instance by referring to the instance OR its members creating a strong reference cycle between the closure and the instance. You can use capture lists to break these.

## Strong Reference Cycles & Capture Lists

Imagine you have two toys. You pick up the first toy with your left hand and the second toy with your right hand. Now, something funny happens:

* Toy #1 grabs onto your right hand
* Toy #2 grabs onto your left hand

Now you're stuck! You can't put down Toy #1 because Toy #2 is holding your hand that's holding Toy #1. And you can't put down Toy #2 because Toy #1 is holding your hand that's holding Toy #2!

This is like a "strong reference cycle" in Swift:

* The class instance (like Toy #1) has a property that's a closure
* The closure (like Toy #2) uses something from the class instance

They're both holding onto each other, and neither can be let go.

To fix this problem, we use something called a "capture list" which is like telling one of the toys "hold on, but don't grab so tight!" This way, when it's time to clean up, one can let go first, and then the other can be put away too.

Without this fix, your toys would stay on the floor forever, and in computers, this is called a "memory leak"!

When a closure is assigned to an instance of a class property and that closure captures the instance itself (through self) or any of its properties, a strong ref cycle occurs. This is because:

1. The class instance keeps a strong ref to the closure (as a property),
2. The closure keeps a strong ref to the class instance (via captured self),
3. Creating a cycle where neither can be deallocated by Swift.

Swift's ARC (Auto Ref Counting) deallocates objects when their reference count is zero. An SRC stops this count from reaching zero.

Here's an example of an SRC with a class and creating an instance later on, setting it to nil.

```swift
class HTMLElement { // This class defines a HTML element in Swift.
    let name: String
    let text: String? // No default value here as we set that in the init.

    // This closure property captures self.
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name)> /"
        }
    }

    // Initialiser
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    // Destructor – specific to classes. This is called automatically by Swift's ARC.
    deinit {
        print("\(name) is being DESTROYED! >:)")
    }
}

// Creating an instance of this class and setting it to nil, bypassing the destructor.

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello!")
paragraph = nil // lol whoops
```

*We can fix this with capture lists*

You use either "weak", "unknown" [these two are reference capturing] or "capturedValue" to define a capture list.

* weak: When the captured reference MIGHT become nil during the closure's lifetime.
    * Requires unwrapping, good for async ops and UI callbacks.

* unowned: " will NEVER be nil while the closure exists.
    * No unwrapping, crashes if accessed after object dealloc.

* capturedValue: Preserving the value of a var that may change later, creating multiple closures that capture diff values from the same variable, improving performance by capturing a computed value once rather than recalculating it each time.
    * Great because it can avoid subtle bugs in async code where vars can change between closure creation and execution.

```swift
lazy var asHTML: () -> String = { [weak self] (param1, param2) in // Sets up the capture list – the capture list is written in square brackets (NOT A COLLECTION).
    guard let self = self else { return "" }
    return "<\(self.name)>\(self.text ?? "")</\(self.name)>" }

// OR

lazy var asHTML: () -> String = { [unowned self] in
    return "<\(self.name)>\(self.text ?? "")</\(self.name)>" } // returns "<p>hello!/<p>
```

Capture lists are not collections, but special syntax that defines how closures capture references from variables in surrounding scope, they tell Swift *"When you create this closure, here's what I want you to capture and HOW I want you to capture it"*. *Param1/2* in the example above refer to parameters that the closure accepts (e.g. s1/s2 when using the sort method). The *in* keyword separates the declaration from implementation.

* Defined at the start of a closure using [], before the parameter list,
* Specifies how certain external vars should be captured in the closure (weak/unowned).

```swift
{ [weak/unowned varName/self] (parameters) -> returnType in
    // closure body
}

// Multiple captures

{ [weak self, weak delegate, capturedIndex = index] in
    // Captured values used here in closure body.
}

```

## Closures Are Reference Types

When assigning a function/closure to a constant/var you're setting said c/v to be a **reference** to the function/closure. If you assign a closure to two different constants/variables, both c/vs refer to the SAME closure.

## Escaping Closures

Closures "escape" when a closure passed to a function as an argument is called AFTER the function returns. You mark the parameter as @escaping when defining the function to allow this. You can think of these as helper jobs that occur after the main task is done.

```swift
// Stores closures that can be executed after the function returns (escaping closures).
var completionHandlers: [() -> Void] = [] // completionHandlers is an ARRAY of CLOSURES.
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler) // The closure passed in as "completionHandler" is appended to an array OUTSIDE the scope of this function.
}
```

If we did not mark the closure parameter with @escaping, this would produce a compile time error.

Escaping closures with .self have additional considerations that need to be made (if self refers to an instance of a class).

## Autoclosures

Closures automatically created to wrap an expression passed as an argument to a function, taking no args and returning the value of the wrapped expression.

You may often call funcs that take autoclosures but you won't implement them often (because they can make your code hard to read when used in excess). Below is an example of how you can delay evaluation using a closure.

```swift
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Prints "5"


let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// Prints "5"


print("Now serving \(customerProvider())!")
// Prints "Now serving Chris!"
print(customersInLine.count)
// Prints "4"
```

Though the 1st element of the array is removed by the code within the closure, this doesn't happen until the closure is actually called. *If the closure is never called, the expression within the closure is never evaluated, so the object at index 0 is never removed.* We'll rewrite the above code using an autoclosure (it automatically converts the string type into a closure, because the parameter is marked with @autoclosure).

```swift
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func serve(customer customerProvider: @autoclosure () -> String) { // customerProvider is a function that takes no parameters and outputs a string.
    print("Now serving: \(customerProvider())!") // We pass that closure into this print method.
}

serve(customer: customersInLine.remove(at: 0) // Prints "Now serving: Chris!"

```