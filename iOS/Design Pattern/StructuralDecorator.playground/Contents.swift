import Foundation

// https://medium.com/swiftcraft/swift-solutions-decorator-pattern-49fcfb18c1ce
// Decorator Pattern
// Dynamically modifies the behavior of a core object WITHOUT changing its existing functionality
// BEHAVIOUR MODIFICATION & ACHIEVED DYNAMICALLY

protocol Transporting {
    func getSpeed() -> Double
    func getTraction() -> Double
}

final class RaceCar: Transporting {
    private var speed: Double = 10
    private var traction: Double = 10
    
    func getSpeed() -> Double {
        return speed
    }
    
    func getTraction() -> Double {
        return traction
    }
}

//MARK: Adding a Decorator
class OffRoadTireDecorator: Transporting {
    
    private var transportable: Transporting
    
    init(_ transportable: Transporting) {
        self.transportable = transportable
    }
    
    func getSpeed() -> Double {
        return transportable.getSpeed() - 3.0
    }
    
    func getTraction() -> Double {
        return transportable.getTraction() + 3.0
    }
}

// Create a Car
let car = RaceCar()

car.getSpeed()
car.getTraction()

// Modify the car
let offRoadCar = OffRoadTireDecorator(car)
offRoadCar.getSpeed()
offRoadCar.getTraction()

