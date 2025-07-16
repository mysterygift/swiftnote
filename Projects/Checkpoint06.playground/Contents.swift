import Cocoa

// Create a struct to store information about a car, including its model, number of seats, and current gear, then add a method to change gears up or down.

// Have a think about variables and access control: what data should be a variable rather than a constant, and what data should be exposed publicly? Should the gear-changing method validate its input somehow?

struct Car {
    var model: String
    var seats: Int
    private var currentGear: Int = 1
    private var topGear: Int
    
    mutating func changeGear (_ direction: String) {
        if direction == "up" {
            if currentGear < topGear {
                currentGear += 1
                print("Now in \(currentGear)")
            } else {
                print("I'm giving your \(model) all she's got captain!")
            }
        } else if direction == "down" {
            if currentGear > 1 {
                currentGear -= 1
                print("Now in \(currentGear)")
            } else {
                print("I'm not going any further, I'm stuck!")
            }
        }
    }
    
    init(model: String, seats: Int, topGear: Int) {
        self.model = model
        self.seats = seats
        self.topGear = topGear
    }
    
}

var myCar = Car(model: "Toyota Corolla", seats: 5, topGear: 5)

myCar.changeGear( "up" )
myCar.changeGear( "up" )
myCar.changeGear( "up" )
myCar.changeGear( "up" )
myCar.changeGear( "up" )
myCar.changeGear( "up" )
myCar.changeGear( "down" )
myCar.changeGear( "down" )
myCar.changeGear( "down" )
myCar.changeGear( "down" )
myCar.changeGear( "down" )
myCar.changeGear( "down" )

var myBetterCar = Car(model: "Bentley Bentayga", seats: 7, topGear: 7)

myBetterCar.changeGear( "up" )
myBetterCar.changeGear( "up" )
myBetterCar.changeGear( "up" )
myBetterCar.changeGear( "up" )
myBetterCar.changeGear( "up" )
myBetterCar.changeGear( "up" )
myBetterCar.changeGear( "up" )
myBetterCar.changeGear("down")
myBetterCar.changeGear("down")
myBetterCar.changeGear("down")
myBetterCar.changeGear("down")
myBetterCar.changeGear("down")
myBetterCar.changeGear("down")
myBetterCar.changeGear("down")
myBetterCar.changeGear("down")
