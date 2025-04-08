# Control Transfer Statements

Change the order of code execution. They include:

* continue
* break
* fallthrough
* return (described in functions.md)
* throw (described in errors.md or some similar file – not written those notes yet!)

# Continue

Used to tell a loop to stop and then start the next iteration of the loop. This example removes all whitespace and vowels from a phrase and then outputs a string.

```swift
let inputPhrase = "it is what it is"
var outputPhrase = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
for character in inputPhrase {
    if charactersToRemove.countains(character) {
        continue
    }
    outputPhrase.append(character)
}
print(outputPhrase) // prints "tswhtts"
```

# Break

Ends a control statement immediately. In loop statements, this transferse control to the code following the closing } of a loop. Does the same for switch statements. Handy if you have a switch case you want to ignore, which is a good idea if you have to deliberately match a case to ignore to make intentions clear.

If you do not have a default case for a switch statement, you must put a break in there.

Switch does not have fallthrough where when a case is complete it progresses to the next one. The statement is completed as soon as the first match is found. If you need fallthrough behaviour you can state this by:

```swift
let intToDescribe = 5
var description = "The number \(intToDescribe) is"
switch intToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number and also"
    fallthrough
default:
    description += "an integer."
}
```

NB! Fallthrough does NOT check the condition of subsequent case blocks, it just executes the code inside the case.

# Labelled Statements

