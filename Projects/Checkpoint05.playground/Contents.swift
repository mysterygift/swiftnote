import Cocoa

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

//Filter out any numbers that are even
//Sort the array in ascending order
//Map them to strings in the format “7 is a lucky number”
//Print the resulting array, one item per line
//without using temporary variables.

//let output: [String] = luckyNumbers.filter { $0 % 2 == 0 }.sorted().compactMap { String($0) + " is a lucky number" }
//print(output.map { $0 + "\n" })
      
// This outputs everything one array, not line by line. We need to integrate the print command into the closure.

//let output2: [String] = luckyNumbers.filter {
//    $0 % 2 == 0 }.sorted().compactMap { "\(String($0)) is a lucky number"
//    }
//
//print(output2)

let solve = { (numbers: [Int]) in // The problem I was having was not having this set into a function. By doing this, I can tell the closure to expect an array on integers, and have it do each of these processes on each index of the array (including printing).
    numbers.filter { $0 % 2 == 0 }
    .sorted()
    .compactMap { print("\($0) is a lucky number")}
    
}

solve(luckyNumbers)
