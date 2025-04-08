# Types in Swift

Types in Swift are static and strongly typed; the type of a variable is known at compile time and the type of a variable can't be changed once it's set.

Swift can also infer types.
Variables are declared using the var keyword, as shown below:

```swift
var myVariable: Int = 42
var myVariable2 = 41
```

There are also Float and Doubles (both are decimals).

Doubles are precises to 15dp, Floats are precise to 6dp.

Strings in Swift are declared in "quotation marks".

```swift
var thought: String = "Sick one lad"
```

Generics

You can also make generic types which allow you to write functions once and have them work with a number of data types. See an example below (T is standard practice here but anything can be used):

```swift
func genericSwapper<T>(_ a: inout T, _ b: inout T) {
    let tempA = a
    a = b
    b = tempA
}
```

Parameters a and b are marked as 'inout', allowing them to be modified within the function. We will talk about this more later.

Tuples

Tuples are compound values (different values with different types that can be returned in different ways). These can be referred to by name or number. Looking at the function below:

```swift
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) { // Takes an array of integers as an argument. Returns a tuple with 3 values, min, max and the sum.
    var min = scores[0] // initialises the variable.
    var max = scores[0]
    var sum = 0

    for score in scores { // iterates through the array of scores passed into the function and then alters the max, min and then increments the sum variable.
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
    } sum += score

    return (min, max, score) // returns the tuple.
}

let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
print(statistics.sum) // prints 120
print(statistics.2) // prints 120 because the tuple is zero-indexed as well (so .0 would be min, .1 would be max and .2 is sum)
```