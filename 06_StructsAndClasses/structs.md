# Structs

A *struct* is a general-purpose data construct that we can use to create our own data types. Unlike other languages, we do not need to create separate interface and implementation files (.h and .c files in C++). Like classes, they can:

* Define *properties* to store values.
* Define *methods* to provide functionality.
* Define *initialisers* to setup their initial state.
* Be *extended*, providing functionality beyond their default implementation.
* Conform to *protocols* to provide a standard, expected functionality.
* Define *subscripts* to provide access to their values using subscript syntax.

I will write notes on extensions, protocols and subscripts at a later date.

Swift automatically creates the .init() method for your struct based on the properties you assign it. I've written an example below for a struct, with properties and methods on show.

```swift

struct Project {
    
    let id: UUID
    var name: String
    var directorName: String
    var startYear: Int = Calendar.current.component(.year, from Date())
    var releaseYear = Int

    func printSummary() { // A method.
        print("The project \(name) is directed by \(directorName) and comes out in \(releaseYear).")
    }

    mutating func changeRelease (changeTo newYear: Int) { // If an instance of this struct was assigned to a constant, Swift treats all properties of the struct as constants. Therefore, we need to use the mutating keyword to let Swift know that this function can ONLY run if the struct as assigned to a variable.
        releaseYear = newYear
        print("\(name) is now due to come out in \(releaseYear).")
    }

    mutating func changeStart (changeTo newStart: Int) {  // We can pass arguments into a method as well.
        startYear = newStart
        print("\(name) had its start date changed to \(startYear)")
    }
}

// Initialising a new instance of a struct. More details on customer initialisers below.
var HSM4 = Project(name: "High School Musical 4", directorName: "Johnny Director", releaseYear: 2028)

HSM4.printSummary() // Prints "The project High School Musical 4 is directed by Johnny Director and comes out in 2028."
HSM4.changeStart(changeTo: 2063) // Prints "High School Musical 4 had its start changed to 2063."
```

## Getters and Setters

A struct's *properties* come in two forms: **stored** (holds the data within the struct) and **computed** (calculated each time the struct is accessed). This is useful, but sometimes we may want to keep track of the original value of the variable. So what do we do? We create a separate computed variable based on multiple stored variables. See below.

```swift
struct ProjectBudget {
    var totalBudget: Double
    var totalSpend: Double

    var remainingBudget: Double {
        totalBudget - totalSpend
    }
    
}
```

But what if we want to occasionally manually set the value of remainingBudget? We'll need to user a *getter* and a *setter* to describe what to do when *reading* and *writing* this variable.

```swift
struct ProjectBudget {
    var totalBudget: Double
    var totalSpend: Double

    var remainingBudget: Double {
        get {
            totalBudget - totalSpend
        }
        set {
            totalBudget = totalSpend + newValue // newValue is automatically created by Swift and passes in the new value being set by the expression.
        }
    }
}
```

**NB:** Computer properties MUST have an explicit type.

## Property Observers

The *willSet* and *didSet* observers allow us to implement behaviour just before or after a *variable* in a struct changes. Obviously these cannot be attached to constants, as they will never change. See an example below.

```swift
struct AddressBook {
    var contacts = [String]() {
        willSet {
            print("Current value is \(contacts)")
            print("New value will be \(newValue)")
        }

        didSet {
            print("There are currently \(contacts.count) contacts.")
            print("The old value was \(oldValue).") // oldValue works the same as newValue (only with the didSet observer)
        }
    }
}

var myBook = AddressBook()
myBook.contacts.append("Tim Cook") // This updates the array at myBook.contacts – therefore triggering the willSet and didSet observers.
```

## Custom Initialisers

Whilst Swift does create a .init() for you when declaring a new instance of a struct, you can create your own (but you **must** assign every variable a value by the time the initialiser finishes). Just remember there is no func keyword before the initialiser. See below.

```swift
struct Player {
    let name: String
    let id: Int

    init(name: String) {
        self.name = name // self._ means the PARAMETER of the struct is being assigned the value of name.
        id = Int.random(in: 1...9) // We can define custom logic for initialisation within a custom init().
    }
}
```

You can call your struct's methods within the initialiser, but only after the properties have all been assigned a value.

## Static Properties & Methods

Occasionally, you will want to add a property OR method to the struct itself, not to a single instance of a struct. We would use this in SwiftUI with example data, or to store constant data that has to be accessed in multiple places across a program (for example, tracking the number of projects a user has (or the number of entries)).

```swift
struct School {

    static var studentCount = 0 // Because this is static, this variable is shared across ALL instances (and not copied between them).

    static func add(student: String) {
        print("\(student) joined the school.")
        studentCount += 1
    }
}

School.add("John B")
print(School.studentCount) // Prints 1
```

Note above that we don't need to add the mutating var to the function above, as there is no instance where these variables are associated with a constant (as they impact a var *attached* to the School struct itself). We call methods for this struct by typing the struct name itself (School.method(_:) in this case).

You cannot access non-static code from static code because Swift would not know which instance to access. But you *can* access static code from non-static code using **Self** (not **s**elf). Self's capitalised because it's refering to the struct itself.

* self: the current *value* of a struct
* Self: the current *type* of struct

Let's look at a use case for this, where we save user settings.

```swift
struct AppData {
    static let version = "1.4 Beta 5"
    static let saveFileName = "settings.json"
    static let homeURL = "https://arandavies.co.uk"
}

// With this approach, we can just read the static properties of the AppData struct, anywhere in the code.

// Let's see how we can store example data in Swift – this is useful for writing code in SwiftUI especially when working with previews.

struct Employee {
    let username: String
    let password: String

    static let example = Employee(username: "john.appleseed", password: "pa55w0rd!")
}
```