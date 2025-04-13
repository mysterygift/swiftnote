# Function

All functions in Swift have types: a function's parameter types and return type. You can pass functions as parameters to other functions, and return functions from other functions. You can write functions WITHIN functions to encapsulate useful functionality within a nested scope.

When defining functions, defining parameters and their types as well as the return type is optional.

```swift
func greet(person: String) -> String {
    let greeting = "Hello," + person + "."
    return greeting
}

print(greet(person: "Tim")) // prints "Hello, Tim."

// This can be further abbrieviated...

func greetAgain(Person: String) -> {
    return "Hello again," + person + "."
}

print(greetAgain(person: "Aran")) // Prints "Hello again, Aran."
```

# Function Parameters and Return Values

When calling a function with zero parameters you still need to use parenthesis. Here is an example.

```swift
func HelloWorld() -> String {
    return "Hello, World"
}

print(HelloWorld()) // Prints "Hello, World"
```

In this case the function ALWAYS returns the same string.

When working with multiple input parameters, you must pass in the arguments in the same order that the parameters are defined. See below.

```swift
func greet(person: String, alreadyGreeted: Bool) –> {
    if alreadyGreeted {
        return greetAgain(person: person) // Passes in the string argument of greet(person:alreadyGreeted:) as an argument for greetAgain(person:)
    } else {
        return greet(person: person)
    }
}
```

When calling functions w/out return values, the return type is automatically set to Void (an empty tuple). Here is an example. Note how no return statement is needed with a void function as it automatically exits the code bloc.

```swift
func logMessage(_ s: String) {
    print("Message: \(s)")
}

let logger: (String) -> Void = logMessage // This type annotation says that logger will take a string in and return nothing when logMessage is assigned to it.
logger("This is a void function")
```

You can also ignore values returned by a function (although functions that have a return type MUST return one.) Below is an example of two functions that print to the terminal, but one of them also returns a value.

```swift
func printAndCount(s: String) -> {
    print(s)
    return s.count
}

func printString(s: String) {
    let _ = printAndCount(s: s) // I'll talk about patterns in a later section – this is a discard pattern. It's telling Swift that I know this expression returns a value, I don't want to store it in a named variable – choosing to DISCARD it. This will avoid compiler warnings about unused vars.
}
```

Functions can also return multiple values as a tuple. Here is an example of an array that returns the minimum and maximum values within an array of integers.

```swift
func minMax(array: [Int]) –> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

```

Because the returned tuple's member values are named as part of the function's return type (min, max), you can access them with dot syntax.

```swift
let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")
```

If the tuple returned has the potential to have no type you need to use optionals to facilitate the nil as follows.

```swift
(Int, String)? // the ENTIRE tuple is optional, not just the individual values within the tuple.
(Int?, String?) // either the string or the int are optional. NOT the same as above.
```

Let's add optionals to minMax(array:) to check for empty arrays.

```swift
func minMax(array: [Int]) –> (min: Int, max: Int)? {
    // Check if the array is empty
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) { // Optional binding here unwraps the optional and assigns it to a constant, executing the function only if the unwrapping succeeds (if the value in the array is not nil). If it is nil the code block is skipped.
    print("min is \(bounds.min) and max is \(bounds.max)")
}

```

# Argument Labels and Parameter Names

Argument labels are specified before the parameter name, and they allow functions to be called in a sentence-like manner providing function bodies that are clear to read.

```swift
func someFunction(argumentLabel parameterName: Int) {
    // Here you can use parameterName to refer to the argument value for said parameter.
}
```
```swift
func greet(person: String, from hometown: String) -> {
    return "Hello \(person)! Glad you could visit from \(hometown)."
}

print(greet(person: "Dave", from: "Dubai")) // prints "Hello Dave! Glad you could visit from Dubai."
```

You can write an underscore if you wish to omit argument labels. Here is an example.

```swift
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
}

someFunction(1, secondParameterName: 2) // we don't need an argument label for the first argument as it isn't specified in the function definition.
```

## Default Parameter Values

You can also give parameters default values, which then don't have to have arguments passed when calling said function. It's best practice to put parameters with default values at the end of the function as they're seen as less important.

```swift
func defaultArgs(_ noDefault: Int, _ yesDefault: Int = 3) {
}

defaultArgs(3, 1) // noDefault = 3, yesDefault = 1
defaultArgs(5) // noDefault = 5, yesDefault = 3 - notice how no argument was passed for yesDefault.
```

## Variadic Parameters

These except zero or more values of a specific type and you specify them as follows:

```swift
func calculateMean (_ numbers: Double...) -> Double { // numbers takes in varying number of doubles as arguments.
    var total: Double = 0
    for number in numbers { // We can iterate through a variadic parameter as it stores them in some sort of list.
        total += number
    }
    return total/Double(numbers.count)
}

calculateMean(6, 23, 87, 4, 56)

```

Internally, VPs are represented as constant arrays so you can use array methods on them (these are converted at runtime).

## In-Out Parameters

Function parameters are constants by default – but by defining them as inout parameters (data is passed into a function, changed and then the change persists afterwards) you can change parameter if it's a variable.

You also have to place an & before the variable name when passed as an arg to indicate that it's modified by the function. (Similar behaviour to pass-by-reference for most use cases but NOT the same implementation).

```swift
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let tempA = a
    a = b
    b = tempA
}

// Example of passing in variables as args for an in-out.

var someInt = 3
var anotherInt = 9

swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt) and anotherInt is now \(anotherInt).") // Prints "...is now 9 and...is now 3."
```

IMPORTANTLY this isn't the same as returning a function as it is literally changing the variables that are passed in.

## Function Types

The combination of parameter and return types can be described as a function's type. For example, a function that takes in two integers and returns another integer could have its type described as (Int, Int) -> Int.

Another example is a function that just prints hello world with the type () -> Void. See below.

```swift
func helloWorld() {
    print("hello world")
}

```

So WHY ARE THESE USEFUL? You can use function types like any other type in swift, for example:

```swift
var mathFunction: (Int, Int) -> Int = addTwoInts // Defines the var mathFunction of that function type and set it to refer to addTwoInts. So you can now call addTwoInts by using the name mathFunction.

print("Resullt: \(mathFunction(3, 9))") // Prints "Result: 12"
```

You can then swap out which function mathFunction is set to. You can even have Swift infer the function type. (let anotherMathFunction = addTwoInts) would set the type of anotherMathFunction to (Int, Int) -> Int.

Function types can also be used as parameter types, allowing you to leave bits of how the function is implemented to the caller. See the example nelow.

```swift
func printResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathfunction(a, b))")
}

printResult()
```

You can also have functions as the return type.

```swift
func addOne(_ input: Int) -> {
    return input + 1
}

print(addOne(3)) // Prints 4
```

Here's an example of the same thing but with bools – chooseStepFunction(backward: Bool) -> (Int) -> Int. This function returns either the stepForward(\_:) or stepBackward(\_:) functions based on a bool called backward. Obviously in this context you would need to have these functions already defined otherwise the return type will not play nice with the compiler.

```swift
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

// Because there is a bool here you can actually use comparators that return true/false instead.

var currentValue = 3
let approachZero = chooseStepFunction(backward: currentValue > 0) // cV returns true, so it executes stepBackward(_:)

// We can make a dramatic countdown too...

print("Counting down:")
while currentValue != 0 {
    print("\(currentValue)...")
    currentValue = approachZero(currentValue)
}
print("zero!")
```

# Nested Functions

All of the above have been defined in the global scope. You can nest functions within other functions, which are by default hidden from the rest of the program (but can be used by their enclosing function). An enclosing function can also return one of its nested functions to expand its scope.

Rewriting cSF to use and return nested functions:

```swift
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 } // The forward and backward functions are defined within the scope of the enclosing "chooseStepFunction" as the functionality does not need to be accessed globally.
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward // Returns one of the two functions.
}

var currentValue = -4
let approachZero = chooseStepFunction(backward : currentValue > 0) // Will return false, so cSF returns stepForward which approachZero refers to. This will dynamically change depending on the currentValue.

while currentValue != 0 {
    print("\(currentValue)...")
    currentValue = approachZero(currentValue) // stepForward and stepBackward functions have a type that requires an int, so we pass that in here.
}
print("zero!")
```