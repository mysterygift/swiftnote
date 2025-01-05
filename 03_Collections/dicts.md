# Dicts

Key : Value pairs. See syntax below. Remember to put , separators between each kv pair. These have the same constant time lookup that sets have.

```swift
let newDict: [String: Int] = [
    "phone": "iPhone X",
    "laptop": "Macbook Pro",
    "tablet": "iPad",
]

devices["phone"] // Retrieves the value associated with this key "phone".
```
This is techinically the shorthand way of declaring a Dictionary, but it's the prefered method.

Here is an example of them being used in context.

```swift
struct Developer {
    let name: String
    let jobTitle: String
    var devices: [String : String]

    var emptyDict: [Int: String]
}
```

# Accessing/Modifying Dicts

Possible through methods, properties and "subscript syntax". The .count property is shared with arrays.

```swift
var airports: ["DXB": "Dubai International", "LHR": London Heathrow, "CHG": Changi International]
print("We have \(airports.count) airports on file.")
```

.isEmpty property has identical functionality, returning a boolean if count = 0.

Here is an example of how we can use subscript syntax to add a new kv pair to a dict.

```swift
airports["DUB"] = "Dublin" // Just make sure that the data type is appropriate! We can also change the value paired with a key in this way.
airports["DUB"] = "Dublin Airport"
```

There is also an updateValue(_:forKey:) method that does the same thing, but it's more readable to use the subscript syntax. They both return a value of type String? which contains the previous value for a key if one existed (or nil if no prior value existed).

```swift
if let oldValue = airports.updateValue("Dublin Aiport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).") // Prints "The old value for DUB was Dublin".
}
```

See below for an example of how you can mix conditionals with checking the value of a key.

```swift
if let airportName = airports["DXB"] {
    print("The name of the airport is \(airportName).") // Subscript returned a non-nil value, meaning THIS happens!
} else {
    print("That airport is not in the airports dictionary.") // The subscript returned a value of nil, which means this statement is printed.
}
```

KV pairs can be removed by setting the key equal to nil/using the .removeValue(forKey:) method, returning the REMOVED value/nil if no value existed.

# Iterating Over a Dict

Each item is returned as a tuple (key, value), which can be decomposed into temporary constants or variables. See below. We can also pass a tuple to the for-in loop, allowing us to access both the key AND the value in any executed code.

```swift
for airportCode in airport.keys { // the .keys property allows us to only access the KEYS of a dict.
    print("Airport code: \(airportCode)")
}
// Airport Code: LHR
// Airport Code: DXB

for airportName in airport.values { // we can do the same thing with the .values property.
    print("Airport name: \(airportName)")
}
// Airport name: Dubai International
// Airport name: London Heathrow
```

You may need to use an API that expects an array instead. We can use the .keys/.values property for this.

```swift
let airportCodes = [String](airports.keys) // define constant airportCodes as an immutable array of strings using the data returned by airport.keys.
// airportCodes is ["LHR", "DXB"]
```

Remember though, that there is no defined order (unless we use the sorted() method on the keys OR values property!).

On the sorted() method, it defaults to returning elements in ascending order based on their natural order (numbers smallest->largest, strings alphabetically).

You can define custom sorting using certain criteria:

```swift
let sortedKeysDescending = airport.keys.sorted { $0 > $1 }
print (sortedKeysDescending) // Outputs: ["LHR", "DUB", "DXB"]
```

I will write more notes on sorting in a different section as this gets into closures and defining different sorting algorithms.