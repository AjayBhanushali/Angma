import Foundation

// Sync Queue
//print("Sync Queue")
//print("a")
//print(Thread.isMainThread)
//DispatchQueue.global().sync {
//    print(Thread.isMainThread)
//    print("b")
//}
//print("c")
//
//// Async Queue
//print("Async Queue")
//print("a")
//print(Thread.isMainThread)
//DispatchQueue.global().async {
//    print(Thread.isMainThread)
//    print("b")
//}
//print("c")
//
// MARK: Serial Queue
//let serialQueue = DispatchQueue(label: "SerialQueue")
//print("1st Statement")
//serialQueue.async {
//    print(Thread.isMainThread)
////    for i in 0...5 {
////        print("ASYNC Serial queue \(i)")
////    }
//    print("ASYNC Serial queue 1")
//    print("ASYNC Serial queue 2")
//    print("ASYNC Serial queue 3")
//    print("ASYNC Serial queue 4")
//    print("ASYNC Serial queue 5")
//}
//print("2nd Statement")
//print("3nd Statement")
//print("4nd Statement")
//print("5nd Statement")

//serialQueue.async {
//    print("ASYNC Serial queue 6")
//    print("ASYNC Serial queue 7")
//    print("ASYNC Serial queue 8")
//    print("ASYNC Serial queue 9")
//    print("ASYNC Serial queue 10")
//    print("ASYNC Serial queue 11")
//}
//serialQueue.sync {
//    print(Thread.isMainThread)
//    for i in 0...5 {
//        print("SYNC Serial queue \(i)")
//    }
//}
//print("End of serial queue")
//print("----------------------------------------")
//
//let concurrentQueue = DispatchQueue(label: "ConcurrentQueue", attributes: .concurrent)
//print("1st Statement")
//concurrentQueue.sync {
//    print(Thread.isMainThread)
//    for i in 0...5 {
//        print("ASYNC concurrent queue \(i)")
//    }
//}
//print("2nd Statement")
//
//concurrentQueue.async {
//    print(Thread.isMainThread)
//    for i in 0...5 {
//        print("SYNC concurrent queue \(i)")
//    }
//}
//print("End of concurrent queue")
//print("----------------------------------------")

// MARK: Deadlocks in Queues

// 1. In concurrent computing, a deadlock is a state in which each member of a group is waiting for another member, including itself, to take action

//func testGCD() {
//    print("1")
//    DispatchQueue.main.async {
//        print("2")
//
//        DispatchQueue.main.sync {
//            print("3")
//        }
//
//        print("4")
//    }
//    print("5")
//}

//testGCD()

// 2. Deadlock because of sync dispatches
//let serialDLqueue = DispatchQueue(label: "Serial deadlock Queue")
//serialDLqueue.async {
//    print("a")
//    serialDLqueue.sync {
//        print("b")
//    }
//    print("c")
//}
//print("d")

// MARK: WorkItems
//let workItem = DispatchWorkItem {
//    for i in 0...3 {
//        print(i)
//    }
//}
//DispatchQueue.global( ).async {
//    workItem.perform()
//}
//
//DispatchQueue.main.async{
//    workItem.perform()
//}
//
//workItem.cancel()

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
//let queue = DispatchQueue (label: "com.company.app.queue", attributes: .concurrent)
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


//// This blocks the current thread(in our case its main) as well
//group.wait()
//print("alopha")
//
/// Now it will block background thread and not the main one hence, rest of the code execute.
//queue.async {
//    group.wait()
//    print("alopha")
//}

/// NOTIFY
//group.notify(queue: DispatchQueue.main) {
//    print("all tasks done!")
//}

//print(Thread.isMainThread)
//for i in 0...70 {
//    print("MAIN \(i)")
//}
//
    
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
//let semaphore = DispatchSemaphore(value: 0)
//var sharedResource = [Int]()
//
////semaphore.wait() // 0
//queue.async {
//    for i in 0...3 {
//        sharedResource.append(i)
//    }
//    semaphore.signal() // 1
//}
//
//semaphore.wait() // 0
//queue.async {
//    for i in 4...7 {
//        sharedResource.append(i)
//    }
//    semaphore.signal() // 1
//}
//
//semaphore.wait() // 0
//
//queue.async {
//    for i in 8...10 {
//        sharedResource.append(i) // 1
//    }
//    semaphore.signal() // 0
//}
//
//semaphore.wait() // 1
//print(sharedResource)

struct a {
    var g: b
}

struct b {
    var a: a
}
