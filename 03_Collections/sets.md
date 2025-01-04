# Set

Similar to an array (it's a collection of items) except it is unordered, cannot have duplicate values. Sets have faster insertion, removal and lookup. See syntax below.

```swift
var arrayName = [2, 48, 23, 19, 77, 2, 6]
var mySet: Set<Int> = [] // Declares an empty set of type Int (using a literal)
var arrayToSet = Set(arrayName) // This converts an array into a set. Every time the set is accessed the order is randomised. Any duplicate values are deleted when the array is converted.

var emptySet = Set<String>() // another way of creating an empty set of type String.
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

# Fundamental Set Operations (and Venn Diagrams)

![alt text](https://docs.swift.org/swift-book/images/org.swift.tspl/setVennDiagram~dark@2x.png)

Remember venn diagrams in AS maths? Well they're back. Looking at the diagram above you can see a bunch of methods that are useful when comparing two sets. You can define new sets based on the outcomes of these methods.

.intersection(_:) new set with values common to both sets.
.symmetricDifference(_:) new set with values in either set but not both.
.union(_:) new set with all values in both sets.
.subtracting(_:) new set with values not in the specific set.

```swift
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sorted() // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersection(evenDigits).sorted() // []
oddDigits.subtracting(singleDigitPrimeNumbers).sorted() // [1, 9]
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted() // [1, 2, 9]
```

Looking at set membership, sets can be supersets, subsets or disjointed. These methods below allow us to determine this, returning a boolean.

== operator determines if two sets are identical.
isSubset(of:) determines if the values of set B are contained within set A.
isSuperset(of:) determines if a set contains all of the values in another specified set.
isStrictSubset(of:)/isStrictSuperset(of:) determines if a set is a sub/superset but not equal to another specified set.
isDisjoint(with:) determines if two sets have no common values.

You can see an example below of these methods in action.

```swift
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubset(of: farmAnimals) // returns True
farmAnimals.isSuperset(of: houseAnimals) // returns True
farmAnimals.isDisjoint(with: cityAnimals) // returns True
```