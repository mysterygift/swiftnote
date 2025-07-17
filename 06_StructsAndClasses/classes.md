# Classes

Whilst SwiftUI uses structs extensively for design, it uses *Classes* extensively for its data. Classes are similar to Structs, with some additional features.

* Classes can build on the functionality of another class, *inheriting* all of the parent class' properties and methods (and you can selectively override certain methods).
* You will need to *write your own initialisers/assign default values* because of this inheritance behaviour.
* When you copy an instance of the class, the *data is shared* between them. (e.g. if a user changes their name on one screen, all other views update to reflect the same change).
* You can call a *deinitialiser* when the final copy of a class instance is destroyed.
* Even if a class is assigned to a constant, *you can change its properties if they are variables*.

Where each struct is a unique instance that holds its own data, even if we assign a class to a constant – if the class' properties are variables we can still change the data within the class (we just can't change what class the constant points to...for obvious reasons).

You create a class using the same syntax that you use to create a struct.

```swift
class Game {
    var score = 0
        didSet {
            print("The score is now \(score)!")
        }
}

var newGame = Game()
newGame.score += 10 // Prints ("The score is now 10!")
```

## Inheritance

When defining a class, you can declare its parent/superclass (same thing) with the following syntax:

```swift
class Employee {
    let hours: Int

    func printSummary() {
        print("I work \(hours) a day.")
    }

    init(hours: Int) {
        self.hours = hours
    }
}

// We can make two subclasses of employee that inherit the hours property and initialiser (without having to state this).

class Developer: Employee {
    func work() {
        print("I'm going to write code for \(hours) hours this week.")
    }
}

class Manager: Employee {
    func work() {
        print("Work is for subordinates (I actually will work \(hours) hours this week).")
    }
}
```

Even though these have the same parent class, we can create different instances of .work(_:) methods with distinct functionality. Because they share a parent class, both Developer() and Manager() will share the same method .printSummary().

## Overrriding Superclass Methods

If you want to change the implementation of a superclass' method, you will need to use the *override* keyword. If you try to define a method with an identical name without this keyword, or use override without overriding something in the parent class, your code will not compile. See example below.

```swift
class Developer: Employee {
    override func printSummary() {
        print("Overridden!")
    }

}
```

Swift does *not* require the override keyword if the method you're trying to declare has different parameters (names or types) as you aren't trying to replace the parent method.

You can stop your class from being inherited by using the *final* keyword.

## Initialising Classes

Because the Car() class below inherits from the superclass Vehicle(), we have to pass it up to its superclass for its own initialiser. See below.

```swift
class Vehicle {
    let isElectric: Bool

    func parentMethod() {
        print("I'm a parent method.")
    }

    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

class Car: Vehicle {
    let isConvertible: Bool

    init(isConvertible: Bool) {
        self.isConvertible = isConvertible
        // Now we need to ask the parent class for the initialisers for its properties.
        super.init(isElectric: false)
    }
}

let toyota = Car(isConvertible: True, isElectric: false) // Remember to define your inherited properties when calling a class.
toyota.parentMethod() // Calls inherited method.

```

.super is a value automatically provided by Swift, allowing us to call to parent methods (such as its initialiser). We could also use it for super.parentMethod() *but ONLY inside a class definition*. If the subclass does not have its own initialiser, it will automatically inherit the init() of its superclass (just make sure that any new properties have assigned default values as they will not be set by the inherited initialiser.

## Copying Classes

All copies of a class instance point to the same data, because they are *reference types*, pointing to a shared pot of data.

```swift
class User {
    var username = "Anonymous" // Because this is stored in a class, it will be shared across a class.
}

var user1 = User()
var user2 = user1
user2.username = "Taylor" // This changes the username value for user1 as well, as it is just a reference that points to user1.
```

If you want to make a deep copy (a unique copy of a class), you'll need to make a method for this.

```swift
class User {
    var username = "Anonymous"

    func copy() -> User { // A new function that returns a new instance of User
        let user = User() // Temp var for the new User that is returned.
        user.username = username // Set the username property of this new username to the one of the current instance.
        return user // Return it!
    }
}

var user1 = User()
var user2 = user1.copy() // Now any changes to user2 will not impact user1 as they are separate instances.

```

## Deinitialisers

Run when the last copy of an object is destroyed.

* *Don't use func* when called.
* Can't take parameters or return data, and as such are *not written with parenthesis()*.
* We *never call them directly*.
* Structs do not have deinitialisers as they are all unique.

When these are called depends on scope. When the scope in which a class was created is exited (for example a for loop, or a view or some other scope), the data is destroyed and the memory it used is returned to the system. See the example below.

```swift
class User {
    let id: Int

    init(id: Int) {
        self.id = id
        print("User \(id) I'm alive!")
    }

    deinit {
        print("User \(id) RIP!")
    }
}

var userList = [Users]()

for i in 1...3 {
    let user = User(id: i)
    print("User \(user.id): I'm in control.")
    userList.append(user)
}

print("Loop is finished.")
userList.removeall
print("Array is clear.")

// If you run the code above, you'll see in the terminal that for each iteration in the loop, a new instance is created, the function executes, and then is destroyed (it won't do that if you copy and paste it, because of the array that is appended. You'll see what the instances of the class are only destroyed when the userList array is cleared.)
```

As you can see above, even though the scope in which the instances of the class was exited, the class instances are *not* destroyed until the array is cleared (because a reference to those arrays still exists in the array).

## Working With Variables Inside Classes

As mentioned earlier you can change the data within a class even if an instance of that class is assigned to a constant. That said, it also means if you assign a class to a variable, you can override the instance of a class a variable points to very easily. So:

* Constant Class, Constant Property
* Constant Class, Variable Property
* Variable Class, Constant Property
* Variable Class, Variable Property

This is different from structs, because if a struct is assigned to a constant, it makes all properties a constant. A struct contains all of its data within itself, and you have to mark shared data with static whereas classes refer to other data.

An upside to this is that classes do not need the *mutating* keyword with methods that change their data.