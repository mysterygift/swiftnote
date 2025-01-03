# Arrays etc

Standard as with other languages, arrays in Swift are zero-indexed and ordered. Here is how you can declare arrays (arrays declared empty need an explicit type).

```swift
var ages: [Bool] = []
```

There are a number of useful methods for arrays.

You can get the account of an array using arrayName.count
Specific elements in an array can be accessed using, arrayName.first/arrayName.last. YOU CAN USE AN OPTIONAL HERE IF THE ARRAY IS EMPTY TO AVOID A CRASH! (e.g. arrayName.?last)
arrayName.append(23)
arrayName.insert (VALUE, at: INDEX)

Obviously arrays can be accessed normally as with other languages e.g. ages[3] accesses the fourth item in the array "ages".

Swift features type safety as well, preventing me from appending an incorrect data type to an array.

Arrays can be sorted using the .sort() method. They can also be .shuffle()'d, and .reverse()'d.