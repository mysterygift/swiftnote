# Conditionals

If statements form:

```swift
if x != y {
    // do this
} else if {
    // do that
} else {
    // do something else
}
```
Importantly, all branches of an if expression must have consistent types of values. To prevent Swift from automatically checking the if expression type, you can use values like nil. See the example below.

```swift
let freezeWarning: String? if temperatureInCelsius <= 0 {
    "It's below freezing."
} else {
    nil
}
```
In the above example there is an optional String type, and the nil in the else expression could reference any optional type. To clarify this, we use the following:

```swift
else {
    nil as String? // Clarifying that the nil is to be used in conjunction with the optional String type.
}
```

"If" expressions can respond to unexpected failures by either throwing an error or calling an error function (e.g. fatalError(_:file:line:) that never returns.)

```swift
let weatherAdvice = if temperatureInCelsius > 100 { // Stores the data returned by this function in constant "weatherAdvice"
    throw TemperatureError.boiling
} else {
    "It's mild."
}
```

# Switch

Compares a value against multiple patterns, and when it finds the first one that matches it executes the block of code there.

Simplest form, only compares against same type:

```swift
switch <#value#> {
case <#1#>:
    do this
 case <#2#>,
    <#3#>:
    do that if you respond to 2 OR 3
default:
    otherwise do something else
}
```

Switch statements must cover all possible values and if they can't be, you must define a default case to cover any values not explicitly addressed (must appear last).

Switch statements also have an expression form, the result of which can be stored in a constant or variable.

```swift
let anotherChar: Character = "a"
let message = switch anotherChar {
case "a":
    "Message"
case "z":
    "Message 2"
default:
    "Default message."
}

print(message) // prints "Message"
```

Switch expressions can be used as a value that a function or closure returns, and can also throw errors instead of providing a value for a given case.

Switch statements do NOT require "break" statements as they automatically stop executing as soon as the first matching case is completed. (More details on Break to follow).

You can use also additional conditional statements with cases, and bind values passed into switches to temporary variables. Below is an example.

```swift
let point = (2, 0)
switch point {
case (let x, 0): // binds the first value of the tuple to constant x which is temporary
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case (let x, y):
    print("somewhere else at (\(x), \(y))")
    
} // prints "on the x-axis with an x value of 2"
```

We could also use ranges for each of these cases, e.g. case (-2...3, -2...4), or we can input _ for one of the positions in the tuple to indicate any value can be there e.g. (_, 3).

These can also be used with compound cases:

```swift
var x = 3
case (let x, 0), (0, let x):
    print("x = \(x)") // prints "x = 3"
```

# Where

Switch cases can use a where clause to check for additional conditions. Below is an example where we categorise points on a cartesian plane:

```swift
let point = (1, -1)
switch point {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
} // prints "(1, -1) is on the line x == -y"
```