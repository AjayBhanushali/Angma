//import Foundation
//
//struct Person {
//    var name: String
//
//    mutating func makeAnonymous() {
//        name = "Anonymous"
//    }
//    
//    func dance() {
//        print(name)
//    }
//}
//
//let person = Person(name: "Ed")
////person.makeAnonymous()
//person.dance()
//print(person.name)
//
//class SuperClass {
//    init() {
//        print("1")
//    }
//}
//
//class SubClass: SuperClass {
//    override init() {
//        super.init()
//        print("2")
//    }
//}
//
//let sub = SubClass()
//
//func sort012(array: [Int]) -> [Int] {
//    var newArray = array
//    var low = 0
//    var mid = 0
//    var high = array.count-1
//    
//    while mid <= high {
//        if newArray[mid] == 0 {
//            let temp = newArray[mid]
//            newArray[mid] = newArray[low]
//            newArray[low] = temp
//            low+=1
//            mid+=1
//        } else if newArray[mid] == 1 {
//            mid+=1
//        } else {
//            let temp = newArray[mid]
//            newArray[mid] = newArray[high]
//            newArray[high] = temp
//            high-=1
//        }
//    }
//    
//    return newArray
//}
//
//sort012(array: [0,1,0,1,2,0])
//
//func nextGreaterElemet(array: [Int]) {
//    var visitedArray: [Int] = []
//    visitedArray.append(array[0])
//    
//    for i in 1..<array.count {
//        if !visitedArray.isEmpty {
//            if var lastItem = visitedArray.popLast() {
//                while lastItem < array[i] {
//                    print(lastItem, array[i])
//                    guard let lastItemx = visitedArray.popLast() else {
//                        break
//                    }
//                    lastItem = lastItemx
//                }
//                if lastItem > array[i] {
//                    visitedArray.append(lastItem)
//                }
//            }
//        }
//        visitedArray.append(array[i])
//    }
//    
//    visitedArray.map({print($0)})
//}
//
//nextGreaterElemet(array: [4,5,2,15,8])
//
//func minimumSum(array: [Int]) -> Int {
//    var left = ""
//    var right = ""
//    
//    let sortedArray = array.sorted()
//    
//    for i in 0..<sortedArray.count {
//        if i%2 == 0 {
//            left.append("\(sortedArray[i])")
//        } else {
//            right.append("\(sortedArray[i])")
//        }
//    }
//    print(left, right)
//    return Int(left)! + Int(right)!
//}
//
//minimumSum(array: [6, 8, 4, 5, 2, 3])
//
//
//// Closures
//
//var i = 0
//var closureArray: [()->()] = []
//
//for _ in 1...5 {
//    closureArray.append {
//        print(i)
//        print("yolo")
//        i+=1
//    }
//    i+=1
//}
//
//closureArray[0]()
//closureArray[1]()
//closureArray[2]()
//closureArray[3]()
//closureArray[4]()
//print(i)
//print("=====")
//func someFunctionWithNonescapingClosure(closure: () -> Void) {
//    closure()
//}
//func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
//    completionHandler()
//}
//class SomeClass {
//    var x = 10
//    func doSomething() {
//        someFunctionWithEscapingClosure { self.x = 100 }
//        print(x)
//        someFunctionWithNonescapingClosure { x = 200 }
//        print(x)
//    }
//}
//
//let some = SomeClass()
//some.doSomething()
//
//print("====")
//
//class InterviewTest {
//    var name: String = "Abhilash"
//    lazy var greeting : String = {
//        return "Hello \(name)"
//    }()
//}
////-------------------------
//let testObj = InterviewTest()
//testObj.greeting
//
//
//
//func sortinON(array: [Int]) -> [Int] {
//    var zeroArray: [Int] = []
//    var oneArray: [Int] = []
//    
//    for i in 0..<array.count {
//        if array[i] == 0 {
//            zeroArray.append(0)
//        } else {
//            oneArray.append(1)
//        }
//    }
//    
//    return zeroArray + oneArray
//}
//
//sortinON(array: [0, 1, 0, 1, 0, 0, 1, 1, 1, 0])
//
//
//func sort0n1(arrat: [Int]) -> [Int] {
//    var p1 = 0
//    var p2 = 0
//    
//}
//
//func isItThere(array: [Int], x: Int) -> Bool {
//    var visited: [Int:Int] = [:]
//    
//    for item in array {
//        let lookingFor = x - item
//        
//        if visited[lookingFor] != nil {
//            return true
//        } else {
//            visited[item] = item
//        }
//    }
//    
//    return false
//}
//
//isItThere(array: [0,-1,2,-3,1], x: -2)
//
//func run() {
//    
//    defer {
//        print("b")
//    }
//    
//    defer {
//        print("c")
//    }
//    
//    defer {
//        print("a")
//    }
//}
//
//run()
//
//
//let scores = [100, 80, 85]
//
//let results = scores.map { score in
//    if score >= 85 {
//        return "\(score)%: Pass"
//    } else {
//        return "\(score)%: Fail"
//    }
//}
//
////===
//import Foundation
//
//// Decorator Pattern
//// Dynamically modifies the behavior of a core object WITHOUT changing its existing functionality
//// BEHAVIOUR MODIFICATION & ACHIEVED DYNAMICALLY
//
//protocol Transporting {
//    func getSpeed() -> Double
//    func getTraction() -> Double
//}
//
//final class RaceCar: Transporting {
//    private var speed: Double = 10
//    private var traction: Double = 10
//    
//    func getSpeed() -> Double {
//        return speed
//    }
//    
//    func getTraction() -> Double {
//        return traction
//    }
//}
//
//let car = RaceCar()
//car.getSpeed()
//car.getTraction()
//
