import Foundation

// Define possible errors
enum RootErrors: Error {
    case outOfBounds
    case noRoot
}

// Take a variable in.
// Square numbers from 1 to 100, return the number that when squared is equal to base.
func intSquareRoot(input: Int) throws(RootErrors) {
    
    guard input < 10001 && input > 0 else { // Check that the number is between 1 and 10000.
        throw .outOfBounds // Trigger the error.
    }
    
    for root in 1..<101 { // Minimum and maximum possible values of roots within the valid range of inputs.
        if root * root == input {
            print("The integer square root of \(input) is: \(root)")
            return // GOD i forgot to return to exit the function.
        } // No else statement needed as it will simply just carry on through the loop.
    }
    
    throw RootErrors.noRoot // If it iterates through the whole loop and finds nothing, an error is thrown here.
    
}

do {
    try intSquareRoot(input: 87)
} catch RootErrors.noRoot { // Describe what should happen when an error is triggered.
    print("This number has no integer root.")
} catch RootErrors.outOfBounds {
    print("Please enter a whole number between 1 and 10,000.")
} catch {
    print("An unexpected error occured: \(error.localizedDescription)")
}
