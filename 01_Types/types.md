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