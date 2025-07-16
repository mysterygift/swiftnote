# Access Control

Sometimes you want to add logic around a property to control how they're changed, or that you need certain methods to be called in a specific way. We can demonstrate the issue below.

```swift
struct BankAccount {
    var funds = 0

    mutating func deposit(amount: Int) {
        funds += amount
    }

    mutating func withdraw(amount: Int) -> Bool {
        if funds > amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

// It's all well and good if people modify the funds value through deposit() and withdraw(), but in its current state we can just...

var myAccount = BankAccount()
myAccount.funds = 10000000 // We're rich!
```
We can restrict external access to the funds property using access control:

* private: The variable can only be accessed within the struct.
* fileprivate: The variable can only be accessed within the same file (e.g. the same .swift file).
* public: The variable can be accessed by anyone, anywhere.
* private(set): Let anyone read this externally or internally, but it can only be written by my internal methods.

If you have a private access control property within a struct, you probably will have to create your own initialiser.

