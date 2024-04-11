// Singleton Pattern
// Creates a single instance of a class throughout the application.
// Provides global access of a single instance
// MARK: Singleton
// MARK: Using Global Vars
class GlobalSharedResource {
    func task1() {}
}

let globalSharedResource = GlobalSharedResource()
globalSharedResource.task1()

// MARK: Using static Property and Private Init
class SharedResource {
    static let shared = SharedResource()
    
    private init() {}
    
    func task1() {}
}

SharedResource.shared.task1()

// MARK: Factory
// Provides a consistent interface to create objects, allowing subclasses to alter the type of objects that will be created.
// Encapsulation of object creation logic
// Ease of adding new types of objects without modifying existing code

// Protocol defining the Product
protocol Product {
    func performAction()
}

// Concrete Product 1
class ConcreteProduct1: Product {
    func performAction() {
        print("Performing action for ConcreteProduct1")
    }
}

// Concrete Product 2
class ConcreteProduct2: Product {
    func performAction() {
        print("Performing action for ConcreteProduct2")
    }
}

// Factory protocol
protocol ProductFactory {
    func createProduct() -> Product
}

// Concrete Factory 1
class ConcreteFactory1: ProductFactory {
    func createProduct() -> Product {
        return ConcreteProduct1()
    }
}

// Concrete Factory 2
class ConcreteFactory2: ProductFactory {
    func createProduct() -> Product {
        return ConcreteProduct2()
    }
}

// Client
class Client {
    var factory: ProductFactory
    
    init(factory: ProductFactory) {
        self.factory = factory
    }
    
    func executeAction() {
        let product = factory.createProduct()
        product.performAction()
    }
}

// Usage
let factory1 = ConcreteFactory1()
let client1 = Client(factory: factory1)
client1.executeAction()

let factory2 = ConcreteFactory2()
let client2 = Client(factory: factory2)
client2.executeAction()
