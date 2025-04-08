# Arrays etc

Standard as with other languages, arrays in Swift are zero-indexed and ordered. Here is how you can declare arrays (arrays declared empty need an explicit type). As with variables, the mutability of arrays/other collections is determined by whether the collection is assigned to a variable or a constant (let keyword).

```swift
var ages: [Bool] = []
```

There are a number of useful methods for arrays.

You can get the account of an array using arrayName.count
Specific elements in an array can be accessed using, arrayName.first/arrayName.last. YOU CAN USE AN OPTIONAL HERE IF THE ARRAY IS EMPTY TO AVOID A CRASH! (e.g. arrayName.?last)
arrayName.append(23)
arrayName.insert (VALUE, at: INDEX)

You cannot use negative index numbers for arrays like you can in Python (this will throw a runtime error). You can add something to the start of an array by using .insert(_:at:) – you'd have to insert the value _ at index 0.

You can check if an array is empty using the .isEmpty method.

Obviously arrays can be accessed normally as with other languages e.g. ages[3] accesses the fourth item in the array "ages".

Swift features type safety as well, preventing me from appending an incorrect data type to an array.

Arrays can be sorted using the .sort() method. They can also be .shuffle()'d, and .reverse()'d.

Arrays can also be added together by using their variables (e.g. newArray = arrayOne + arrayTwo)

Iterating through arrays is the same as in other languages (for x in arrayName {do stuff}).

# Creating Arrays with Default Values

The array collection also has an initialiser for creating arrays of x size with default value at each index. See an example below.

```swift
var sixStrings = Array(repeating: String, count: 6) // [String, String, String, String, String, String]
```

# Safely Inserting Values into Arrays with Changing Lengths

You can use a function to ensure you don't insert a value outside the bounds of a particular array.

```swift
func safeInsert<T>(_ element: T, at relativePosition: Double, in array: inout [T]) { // use of generics here ensures that the type of the argument element matches the type of the array
// inout means the function can change the value of a variable outside the scope of the function and this change persists. You must use & before the name of an inout variable.
    guard relativePosition >= 0.0, relativePosition <= 1.0 else {
        print("Position must be between 0.0 and 1.0")
        return
    }

    let position = Int(Double(array.count) * relativePosition)
    array.insert(element, at: min(position, array.count)) // The use of min here is a safety feature that makes sure the array is inserted at a position that is the lesser of the two values (position or array.count).

    // If I was rounding down I would have used Int(floor(number)) or just Int(number) to truncate decimal points.

}

var numbers [1, 2, 3, 4]
safeInsert(99, at: 0.5, in: &numbers)
```