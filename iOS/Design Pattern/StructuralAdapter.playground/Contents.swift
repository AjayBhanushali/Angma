import Foundation

// https://medium.com/swiftcraft/swift-solutions-decorator-pattern-49fcfb18c1ce
// https://chetan-aggarwal.medium.com/ios-design-patterns-f478abd78132
// Adapter Pattern
//

protocol Jumping {
  func jump()
}

class Dog: Jumping {
  func jump() {
    print("Jumps Excitedly")
  }
}

class Cat: Jumping {
  func jump() {
    print("Pounces")
  }
}
 
let dog = Dog()
let cat = Cat()


final class Frog {
    func leap() {
        print("Leaped")
    }
}

extension Frog: Jumping {
    func jump() {
        leap()
    }
}

let frog = Frog()
frog.jump()
