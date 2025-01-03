# Set

Similar to an array (it's a collection of items) except it is unordered, cannot have duplicate values. Sets have faster insertion, removal and lookup. See syntax below.

```swift
var arrayName = [2, 48, 23, 19, 77, 2, 6]
var mySet: Set<Int> = [] // Declares an empty set of type Int.
var arrayToSet = Set(arrayName) // This converts an array into a set. Every time the set is accessed the order is randomised. Any duplicate values are deleted when the array is converted.
```

Why do sets have better performance than arrays? In order for something to go into a set, it must conform to "Hashable" protocol. Basic Swift types conform to Hashable automatically, but when creating custom data types the protocol need to be integrated for each object.

If something is Hashable it is given a hashValue.

For example, looking at the array we set earlier:

```swift
var arrayName = [2, 48, 23, 19, 77, 2, 6]
var arrayToSet = Set(arrayName)

arrayToSet.contains(23) // returns a boolean.
```

Sets can run the .contains() method with constant time lookup, however an array has to iterate through each entry checking if it contains the member declared in the parenthesis. Despite how big the set gets, the time will be constant.

Items can be added into a set using the .insert() method (order doesn't matter so!)