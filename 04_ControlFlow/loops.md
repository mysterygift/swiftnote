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

Importantly, we can use these beyond subscripts. You CANNOT iterate over a one-sided range that omits its first value as it's unclear where the iteration starts. You can iterate over a one-sided range without an ending as long as you provide some sort of explicit end condition for the loop (otherwise it will repeat endelessly).

# White Loops