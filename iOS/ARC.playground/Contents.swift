import UIKit

func print(address o: UnsafeRawPointer) {
    print(String(format: "%p", Int(bitPattern: o)))
}

struct User {
    var name: String
}

var user1 = User(name: "A")
var user2 = user1

print(address: user1)
print(address: user2)

//var array1 = ["A"]
//var array2 = array1
//print(address: array1)
//print(address: array2)
//
//array2.append("B")
//print(address: array1)
//print(address: array2)

var name1 = "A"
var name2 = name1

print(address: name1)
print(address: name2)

name2 = "B"

//print(name1)
print(address: name1)

print(name2)
print(address: name2)

//class Aclass {
//    init() {
//        print("A")
//    }
//}
//
//class Bclass: Aclass {
//    override init() {
//        print("B")
//    }
//}
//
//class Cclass: Bclass {
//    override init() {
//        print("C")
//    }
//}
//
//let c = Cclass()

// Closures

//var i = 0
//var closureArray: [()->()] = []
//
//for _ in 1...5 {
//    closureArray.append { //[i] in
//        print(i)
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
//
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

// MARK: WEAK

class A {
    var b: B
    init(_ b: B) {
        self.b = b
    }
    
    deinit {
        print("A gone")
    }
}

class B {
//    var a: A?
    weak var a: A?
    deinit {
        print("B gone")
    }
}
var b: B? = B()
var a: A? = A(b!)
b!.a = a

a = nil
b = nil

// Closures Captures

class Manager {
    func youNeedEscape(_ callBack: @escaping ()->Void, callBack2: ()->Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
            callBack()
        }
//        DispatchQueue.global().sync { //This wont required escape as it inside runs on the main thread.
//            callBack()
//        }
        callBack2()
    }
}

Manager().youNeedEscape {
    print("Escaped")
} callBack2: {
    print("Nonescaped")
}



