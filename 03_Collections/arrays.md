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