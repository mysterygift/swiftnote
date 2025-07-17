import Cocoa

//  make a class hierarchy for animals, starting with Animal at the top, then Dog and Cat as subclasses, then Corgi and Poodle as subclasses of Dog, and Persian and Lion as subclasses of Cat.


//The Animal class should have a legs integer property that tracks how many legs the animal has. inherited
//The Dog class should have a speak() method that prints a generic dog barking string, but each of the subclasses should print something slightly different. override for corgi and poodle
//The Cat class should have a matching speak() method, again with each subclass printing something different. override for persian and lion
//The Cat class should have an isTame Boolean property, provided using an initializer.

class Animal {
    var legs: Int = 4
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    
    func speak() {
        print("Bark!")
    }
    
    init() {
        super.init(legs: 4)
    }
}

class Cat: Animal {
    
    var isTame: Bool
    
    func speak() {
        print("Meow...")
    }
    
    init(isTame: Bool) {
        self.isTame = isTame
        super.init(legs: 4) // So we put the variable here that we want to pass up to the init(_:) for the class Animal().
    }
}


class Corgi: Dog {
    override func speak() {
        print("Yip yip!")
    }
}

class Poodle: Dog {
    override func speak() {
        print("Borf borf!")
    }
}

class Persian: Cat {
    override func speak() {
        print("Meeeoooooww")
    }
}

class Lion: Cat {
    override func speak() {
        if isTame {
            print("Wagwan")
        } else {
            print("ROAR!")
        }
    }
}

let myLion = Lion(isTame: true)
myLion.speak()

let myPersian = Persian(isTame: false)
myPersian.speak()

let myCorgi = Corgi()
myCorgi.speak()

let myPoodle = Poodle()
myPoodle.speak()

let myDog = Dog()
myDog.speak()

let myCat = Cat(isTame: true)
myCat.speak()
