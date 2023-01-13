import UIKit
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



