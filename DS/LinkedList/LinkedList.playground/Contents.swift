//MARK:- Linked List

// Linked List
struct LinkedList<Value> {
  var head: Node<Value>?
  var tail: Node<Value>?
  
  var isEmpty: Bool {
    return head == nil
  }
  
  init() {}
  
  // Push Implementation
  mutating func push(_ value: Value) {
    // 1. Creating a new Node
    // 2. Assigning new Value
    // 3. Assigning current head as Next Node
    // 4. New Head is ready
    let newHead = Node(value: value, next: head)
    
    // 5. Replacing the current head with new head
    head = newHead
    
    // If tail is nil, then, assign head to it.
    if tail == nil {
      tail = head
    }
  }
  
  // Append Implementation
  mutating func append(_ value: Value) {
    
    // If the list is empty, then, use push method.
    guard !isEmpty else {
      push(value)
      return
    }
    
    // 1. Creating a node with new value and no next node
    let newTailNode = Node(value: value)
    
    // 2. Assigning newTailNode to existing tail node as it's next node
    tail!.next = newTailNode
    
    // 3. Finally, assign newTailNode as a tail
    tail = newTailNode
  }
  
  // Node at index Implementation
  // For Example: 10 -> 22 -> 14
  func node(at index:Int) -> Node<Value>? {
    var currentIndex = 0
    var currentNode = head
    // 1. Since, it is not array, we go to each node unless we reach till the required index
    while(currentNode != nil && currentIndex < index) {
      // 2. we will assign the next node to currentNode
      currentNode = currentNode?.next
      currentIndex += 1
    }
    return currentNode
  }
  
  // Insert Implementation
  func insert(_ value :Value, after node :Node<Value>) {
    // 1. node's next node becomes newNode's next node
    let newNode = Node(value: value, next: node.next)
    // 2. then, newNode becomes node's next node
    node.next = newNode
  }
  
  // Pop Implementation
  mutating func pop() -> Value? {
    
    defer {
      // 1. We are simply removing the head by replacing it with it's next node
      head = head?.next
      
      // 2. If the head is nil, then we have to remove tail as well
      if isEmpty {
        tail = nil
      }
    }
    
    return head?.value
  }
  
  // Remove Last implementation
  mutating func removeLast() -> Value? {
    // 1. If head is nil, then just return nil
    guard let head = head else {
      return nil
    }
    
    // 2. If only 1 item is there in the list, then use pop func
    guard head.next != nil else {
      return pop()
    }
    
    var prevNode = head
    var currentNode = head
    
    // 3. We are going through each element unless we get secondLast and lastItem
    while let nextNode = currentNode.next {
      prevNode = currentNode
      currentNode = nextNode
    }
    
    // 4. removing last node from second last node's next
    prevNode.next = nil
    
    // 5. replacing tail with second last node, hence, last node will no longer be available
    tail = prevNode
    
    return currentNode.value
  }
  
  // Remove After Implementation
  mutating func remove(after node: Node<Value>) -> Value? {
    defer {
      // 1. If next node is tail, then it's our job to change the tail to node
      if node.next === tail {
        tail = node
      }
      // 2. We are simply skipping the node which we want to remove
      node.next = node.next?.next
    }
    // 3. Returning, the value which is going to be deleted
    return node.next?.value
  }
}

extension LinkedList: CustomStringConvertible {
  var description: String {
    guard let head = head else {
      return "Empty"
    }
    
    return String(describing: head)
  }
}

// Node
class Node<Value> {
  var value: Value
  var next: Node?
  
  init(value _value: Value, next _next: Node? = nil) {
    value = _value
    next = _next
  }
}

extension Node: CustomStringConvertible {
  var description: String {
    guard let next = next else {
      return "\(value)"
    }
    
    return "\(value) -> " + String(describing: next) + " "
  }
}

// Demo LinkedList
// Push
//var linkedList = LinkedList<Int>()

//linkedList.push(22)
//linkedList.push(16)
//linkedList.push(8)
//linkedList.push(10)
//linkedList.push(24)

//print(linkedList)
// Append
// Demo
//var linkedList = LinkedList<Int>()
//linkedList.append(24)
//linkedList.append(10)
//linkedList.append(22)
//linkedList.append(16)

//print(linkedList)

// Demo insert
//
//var linkedList = LinkedList<Int>()
//linkedList.append(24)
//linkedList.append(10)
//linkedList.append(22)
//linkedList.append(16)
//
//print(linkedList)
//
//let node = linkedList.node(at: 1)
//linkedList.insert(5, after: node!)
//
//print(linkedList)

// Demo Pop

//var linkedList = LinkedList<Int>()
//linkedList.append(24)
//linkedList.append(10)
//linkedList.append(16)
//
//print(linkedList)
//linkedList.pop()
//print(linkedList)

// Demo RemoveLast

//var linkedList = LinkedList<Int>()
//linkedList.append(24)
//linkedList.append(10)
//linkedList.append(16)
//
//print(linkedList) // Output: 24 -> 10 -> 16
//linkedList.removeLast()
//print(linkedList) // Output: 24 -> 10

// Demo Remove After
var linkedList = LinkedList<Int>()
linkedList.append(24)
linkedList.append(10)
linkedList.append(22)
linkedList.append(16)

print(linkedList) // Output: 24 -> 10 -> 22 -> 16
let node = linkedList.node(at: 1)
linkedList.remove(after: node!)
print(linkedList) // Output: 24 -> 10 -> 16
