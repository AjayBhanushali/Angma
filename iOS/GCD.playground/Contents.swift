import Foundation

//MARK: ARC 1
//class Person {
//    var name: String?
//    var card: Card?
//
//    init(name: String) {
//        self.name = name
//    }
//
//    deinit {
//        print("\(name ?? "") is deinitialised")
//    }
//}
//
//class Card {
//    var cardName: String
//    unowned var person: Person
//
//    init(cardName: String, person: Person) {
//        self.person = person
//        self.cardName = cardName
//    }
//
//    deinit {
//        print("\(cardName) is deinitialised")
//    }
//}
//
//var raj: Person? = Person(name: "Raj")
//var paytmCard: Card? = Card(cardName: "Paytm Card", person: raj!)
//
//raj?.card = paytmCard
//
//paytmCard = nil
//
//print(raj?.card?.cardName)
//print(paytmCard)

// MARK: Struct vs Class
// EXMPLE 1
//class Person {
//    var name: String?
//    var card: Card?
//
//    init(name: String) {
//        self.name = name
//    }
//}
//
//struct Card {
//    var cardName: String
//    var person: Person
//
//    init(cardName: String, person: Person) {
//        self.person = person
//        self.cardName = cardName
//    }
//}
//
//var raj: Person? = Person(name: "Raj")
//var paytmCard: Card? = Card(cardName: "Paytm Card", person: raj!)
//
//raj?.card = paytmCard
//
//raj?.card?.cardName = "Debit Card"
//
//paytmCard?.person.name = "Yash"
//
//print(raj?.name)
//print(raj?.card?.cardName)
//
//print(paytmCard?.cardName)
//print(paytmCard?.person.name)

// EXMPLE 2
//struct A {
//    var b: B?
//}
//
//struct B {
//    var a: A?
//}
//
//var a = A()
//var b = B()
//
//a.b = b
//b.a = a

// MARK: Closures

//var i = 0
//var closureArray: [()->()] = []
//
//for _ in 1...5 {
//    closureArray.append { [i] in
//        print(i)
//    }
//    i+=1
//}
//
//closureArray[0]()
//closureArray[1]()
//closureArray[2]()
//
//print("i is \(i)")



//var i = 0
//var closureArray: [()->()] = []
//
//for _ in 1...5 {
//    closureArray.append { [i] in
//        print(i)
//    }
//    i+=1
//}
//
//closureArray[0]()
//print("i is \(i)")

// MARK: GCD
// MARK: Serial Queue: Sync{Sync{}} DEADLOCK
//let serialQueue1 = DispatchQueue(label: "serial.sync.i.sync")
//// Sync Block 1
//// Note: Serial Queue:
//// > Serial Queue: executes one task at a time in order
//// > For instance, if serial queue = [T1, T2], start T1>End T1>start T2>End T2
//
//// Note: Sync
//// Returns control after the task is completed
//// T1
//serialQueue1.sync { // Queue started running sync T1
//    print("Only this line will get executed")
//    serialQueue1.sync { // sync T2 want to execute now but we are on a serial queue which is already executing T1. HERE, T2 is not letting T1 execute the rest of the code. Hence it is creating a deadlock
//        print("Deadlock")
//    }
//    print("This won't run")
//}
//print("This won't run")

// MARK: Serial Queue: Sync{Async{}}
//let serialQueue2 = DispatchQueue(label: "serial.sync.i.async")
//serialQueue2.sync { // Queue started running sync T1 | Queue = [T1]
//
//    print("This line will get executed")
//
//    serialQueue2.async { // Async will *immediately* return the control Queue = [T1, T2]
//        for i in 0...50 {
//            print("B \(i)------")
//        }
//    }
//
//    for i in 0...50 {
//        print("A \(i)")
//    }
//}
//print("This line will get printed After A and parallel to B")


// MARK: Serial Queue: Async{Async{}}
//let serialQueue3 = DispatchQueue(label: "serial.async.i.async")
//serialQueue3.async { // Async will *immediately* return the control | Queue started running async T1 | Queue = [T1]
//
//    print("This line will get executed")
//
//    serialQueue3.async { // Async will *immediately* return the control | Queue = [T1, T2]
//        for i in 0...50 {
//            print("B \(i)------")
//        }
//    }
//
//    for i in 0...50 {
//        print("A \(i)")
//    }
//}
//print("This will print parallel to T1 | T2 will execute after T1 completes because it is performed in a serial queue")

// MARK: Serial Queue: Async{sync{}} DEADLOCK
//let serialQueue4 = DispatchQueue(label: "serial.async.i.sync")
//serialQueue4.async { // Async will *immediately* return the control | Queue started running async T1 | Queue = [T1]
//
//    print("This line will get executed")
//
//    serialQueue4.sync { // Sync T2 want to execute now but we are on a serial queue which is already executing T1. HERE, T2 is not letting T1 execute the rest of the code. Hence it is creating a deadlock for serial queue not the main queue
//        for i in 0...50 {
//            print("B \(i)------")
//        }
//    }
//
//    for i in 0...50 {
//        print("A \(i)")
//    }
//}
//print("This line will great printed as it on main thread")

// MARK: Serial Queue: sync{} sync{}

//let serialQueue5 = DispatchQueue(label: "serial.sync.sync")
//serialQueue5.sync { //  Queue = [T1]
//    for i in 0...50 {
//        print("A \(i)")
//    }
//}
//
//serialQueue5.sync { // queue = [T2]
//    for i in 0...50 {
//        print("B \(i)------")
//    }
//}
//
//print("Everything will be printed in order")

// MARK: Serial Queue: sync{} async{}
//let serialQueue5 = DispatchQueue(label: "serial.sync.async")
//serialQueue5.sync { //  Queue = [T1]
//    for i in 0...50 {
//        print("A \(i)")
//    }
//}
//
//serialQueue5.async { // queue = [T2]
//    for i in 0...50 {
//        print("B \(i)------")
//    }
//}
//print("C")
//print("First A then (B and C parallel)")

// MARK: Serial Queue: async{} async{}
//let serialQueue5 = DispatchQueue(label: "serial.async.async")
//serialQueue5.async { //  Queue = [T1]
//    for i in 0...50 {
//        print("A \(i)")
//    }
//}
//
//serialQueue5.async { // queue = [T1, T2]
//    for i in 0...50 {
//        print("B \(i)------")
//    }
//}
//print("C")
//print("(First A & C Parrallel) After A finishes B will start")

// MARK: Serial Queue: async{} sync{}
//let serialQueue5 = DispatchQueue(label: "serial.async.sync")
//serialQueue5.async { //  Queue = [T1]
//    for i in 0...50 {
//        print("A \(i)")
//    }
//}
//
//serialQueue5.sync { // queue = [T1, T2]
//    for i in 0...50 {
//        print("B \(i)------")
//    }
//}
//print("C")
//print("A > B > C")

// MARK: Concurrent Queue: Sync{Sync{}}
//let conQueue1 = DispatchQueue(label: "concurrent.sync.in.sync", attributes: .concurrent)
//conQueue1.sync { //  Queue = [T1]
//
//    conQueue1.sync { // queue = [T1, T2]
//        for i in 0...50 {
//            print("B \(i)------")
//        }
//    }
//
//    for i in 0...50 {
//        print("A \(i)")
//    }
//}
//
//print("C")
//print("B > A > C")

// MARK: Concurrent Queue: Sync{Async{}}
//let conQueue2 = DispatchQueue(label: "concurrent.sync.in.async", attributes: .concurrent)
//conQueue2.sync { //  Queue = [T1]
//
//    conQueue2.async { // queue = [T1, T2]
//        for i in 0...50 {
//            print("B \(i)------")
//        }
//    }
//
//    for i in 0...50 {
//        print("A \(i)")
//    }
//}
//
//print("C")
//print("(A parallel B) > C will be print after T1 is over not T2")

// MARK: Concurrent Queue: Async{Async{}}
//let conQueue3 = DispatchQueue(label: "concurrent.async.in.async", attributes: .concurrent)
//conQueue3.async { //  Queue = [T1e]
//
//    conQueue3.async { // queue = [T1e, T2e]
//        for i in 0...50 {
//            print("B \(i)------")
//        }
//    }
//
//    for i in 0...50 {
//        print("A \(i)")
//    }
//}
//
//print("C")
//print("A || B || C")


// MARK: Concurrent Queue: Async{sync{}}
//let conQueue4 = DispatchQueue(label: "concurrent.async.in.sync", attributes: .concurrent)
//conQueue4.async { //  Queue = [T1e]
//
//    conQueue4.sync { // queue = [T1e, T2e]
//        for i in 0...50 {
//            print("B \(i)------")
//        }
//    }
//
//    for i in 0...50 {
//        print("A \(i)")
//    }
//}
//
//print("C")
//print("(B > A) || C")

// MARK: Concurrent Queue: sync{} sync{}
//let conQueue5 = DispatchQueue(label: "concurrent.sync.sync", attributes: .concurrent)
//conQueue5.sync { //  Queue = [T1e]
//    for i in 0...50 {
//        print("A \(i)")
//    }
//}
//
//conQueue5.sync { // queue = [T2e]
//    for i in 0...50 {
//        print("B \(i)------")
//    }
//}
//
//print("C")
//print("A > B > C")

// MARK: Concurrent Queue: sync{} async{}
//let conQueue6 = DispatchQueue(label: "concurrent.sync.async", attributes: .concurrent)
//conQueue6.sync { //  Queue = [T1e]
//    for i in 0...50 {
//        print("A \(i)")
//    }
//}
//
//conQueue6.async { // queue = [T2e]
//    for i in 0...50 {
//        print("B \(i)------")
//    }
//}
//
//print("C")
//print("A > (B || C)")

// MARK: Concurrent Queue: async{} async{}
//let conQueue7 = DispatchQueue(label: "concurrent.async.async", attributes: .concurrent)
//conQueue7.async { //  Queue = [T1e]
//    for i in 0...50 {
//        print("A \(i)")
//    }
//}
//
//conQueue7.async { // queue = [T2e]
//    for i in 0...50 {
//        print("B \(i)------")
//    }
//}
//
//print("C")
//print("A || B || C")

// MARK: Concurrent Queue: async{} sync{}
//let conQueue8 = DispatchQueue(label: "concurrent.async.sync", attributes: .concurrent)
//conQueue8.async { //  Queue = [T1e]
//    for i in 0...50 {
//        print("A \(i)")
//    }
//}
//
//conQueue8.sync { // queue = [T2e]
//    for i in 0...50 {
//        print("B \(i)------")
//    }
//}
//
//print("C")
//print("(B > C) || A")

//===================================

// MARK: Serial Queue
//let serialQueue = DispatchQueue(label: "SerialQueue", attributes: [])
//
//print("1st Statement")
//serialQueue.sync {
//    print("Start")
//    serialQueue.async {
//        for i in 0...50 {
//            print("B \(i)")
//        }
//    }
//
//    for i in 0...50 {
//        print("A \(i) ---------------")
//    }
//}
//
//print("2nd Statement")
//print("3nd Statement")
//print("4nd Statement")
//print("5nd Statement")

// MARK: Deadlocks in Queues

// 1. In serial computing, a deadlock is a state in which each member of a group is waiting for another member, including itself, to take action

//func testGCD() {
//    print("1")
//    DispatchQueue.main.async { //[T1e]
//        print("2")
//
//        DispatchQueue.main.sync { // [T1e, T2]
//            print("3")
//        }
//
//        print("4")
//    }
//    print("5")
//}

//testGCD()

// MARK: WorkItems
//let workItem = DispatchWorkItem {
//    for i in 0...3 {
//        print(i)
//    }
//}
//
//DispatchQueue.global().async {
//    workItem.perform()
//}
//
//DispatchQueue.main.async {
//    workItem.perform()
//}
//
//workItem.cancel()
// ====>WorkItem for seach
//var currentWorkItem: DispatchWorkItem?
//
//func getDataFor(searchString: String) {
//
//    currentWorkItem?.cancel()
//
//    let dispatchWorkItem = DispatchWorkItem {
//        print("DThread: \(Thread.isMainThread)")
//        print(searchString)
//    }
//
//    currentWorkItem = dispatchWorkItem
//
//    currentWorkItem?.notify(queue: .main, execute: {
//        print("TO Thread: \(Thread.isMainThread)")
//    })
//
//    DispatchQueue.global().asyncAfter(deadline: .now() + 2, execute: dispatchWorkItem)
//}
//
//
//
//getDataFor(searchString: "A")
//sleep(3)
//getDataFor(searchString: "AB")
//sleep(1)
//getDataFor(searchString: "ABC")

// MARK: DispatchGroup - wait
//print("starting long running tasks")
////create a group for a bunch of tasks we are about to do
//let group = DispatchGroup()
////launch a bunch of tasks
//for i in 0...3 {
//    //let the group know that something is being added
//    group.enter()
//    //run tasks on a background thread
//    DispatchQueue.global().async{
//        //do some long task eg webservice or database lookup
//        sleep(arc4random() % 4)
//        print("long task \(i) done!")
//        //let group know that the task is finished
//        group.leave()
//    }
//}
////will block whatever thread we are on here until all the above tasks have finished
//// (so maybe dont use this function on your main thread)
//group.wait()
//print("all tasks done!")

// MARK: DispatchGroup - wait(), wait() in concurrent, notify()
//let queue = DispatchQueue(label: "com.company.app.queue", attributes: .concurrent)
//let group = DispatchGroup()
//
//group.enter()
//queue.async {
//    for i in 0...70 {
//        print("l \(i)")
//    }
//    group.leave()
//}
//
//group.enter()
//queue.async {
//    for i in 0...70 {
//        print("M \(i)")
//    }
//    group.leave()
//}
//
//// This blocks the current thread(in our case its main) as well
//group.wait()
//print("alopha")
//
//// Now it will block background thread and not the main one hence, rest of the code execute.
//queue.async {
//    group.wait()
//    print("alopha")
//}
//
//// NOTIFY
//group.notify(queue: DispatchQueue.main) {
//    print("all tasks done!")
//}
//
//print(Thread.isMainThread)
//for i in 0...70 {
//    print("MAIN \(i)")
//}

    
// MARK: DispatchGroup - notify()
//print("starting long running tasks")
////create a group for a bunch of tasks we are about to do
//let group = DispatchGroup()
////launch a bunch of tasks
//for i in 0...3 {
//    //let the group know that something is being added
//    group.enter()
//    //run tasks on a background thread
//    DispatchQueue.global().async{
//        //do some long task eg webservice or database lookup
//        sleep(arc4random() % 4)
//        print("long task \(i) done!")
//        //let group know that the task is finished
//        group.leave()
//    }
//}
//
//group.notify(queue: DispatchQueue.main) {
//    print("all tasks done!")
//}

// MARK: Dispatch Barrier
//let queue = DispatchQueue(label: "com.company.app.queue", attributes: .concurrent)
//queue.async {
//    for i in 0...5 {
//        print("L \(i)")
//    }
//}
//queue.async {
//    for i in 0...5 {
//        print("loom \(i)")
//    }
//}
//
//queue.async(flags: .barrier) {
//    for i in 0...5 {
//        print("Barrier \(i)")
//    }
//}
//
//queue.async {
//    for i in 0...5 {
//        print("hired \(i)")
//    }
//}
//
//queue.async {
//    print("#4 finished")
//}

// MARK: Reader-writer problem

//class PhotoManager {
//
//    private init() {}
//
//    static let shared = PhotoManager()
//
//    private var unsafeNames: [String] = []
//
//    private let concurrentPhotoQueue =
//      DispatchQueue(
//        label: "com.raywenderlich.GooglyPuff.photoQueue",
//        attributes: .concurrent)
//
//
//    var names: [String] {
//      return unsafeNames
//    }
//
//    func addName(name: String) {
//        concurrentPhotoQueue.async(flags: .barrier) { [weak self] in
//            guard let self = self else { return }
//            self.unsafeNames.append(name)
//        }
//    }
//}

// MARK: Dispatch Semaphore
//print("Dispatch Semaphore")
//let queue = DispatchQueue(label: "com.gcd.dispatchSemaphore", attributes: .concurrent)
//let semaphore = DispatchSemaphore(value: 1)
//var sharedResource = [Int]()
//
//semaphore.wait() // 0
//queue.async {
//    for i in 0...3 {
//        sharedResource.append(i)
//    }
//    semaphore.signal() // 1
//}
//
//semaphore.wait() // -1 0
//queue.async {
//    for i in 4...7 {
//        sharedResource.append(i)
//    }
//    semaphore.signal() // 0
//}
//
//semaphore.wait() // -1 0
//
//queue.async {
//    for i in 8...10 {
//        sharedResource.append(i)
//    }
//    semaphore.signal() // 0
//}
//
//semaphore.wait() // -1 0
//print(sharedResource)

//struct a {
//    var g: b
//}
//
//struct b {
//    var a: a
//}
