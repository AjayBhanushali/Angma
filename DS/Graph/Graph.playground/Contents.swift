import Foundation

class Node<Value> {
    var value: Value
    var next: Node<Value>?
    
    init(value: Value, next: Node<Value>? = nil) {
        self.value = value
        self.next = next
    }
}

struct LinkedList<Value> {
    var head: Node<Value>?
    var tail: Node<Value>?
    
    init() {}
    
    var isEmpty: Bool {
        return head == nil
    }
    
    mutating func push(_ value: Value) {
        let newHead = Node(value: value, next: head)
        
        if tail == nil {
            tail = head
        }
        
        head = newHead
    }
    
    mutating func append(_ value: Value) {
        if isEmpty {
            push(value)
        }
        
        let newTail = Node(value: value)
        tail?.next = newTail
        tail = newTail
    }
}

let node1 = Node(value: 1)
let node2 = Node(value: 2)
let node3 = Node(value: 3)
let node4 = Node(value: 4)
let node5 = Node(value: 5)

node4.next = node5
node3.next = node4
node2.next = node3
node1.next = node2

var ll = LinkedList<Int>()
ll.head = node1


func reverseList<Value>(list: inout LinkedList<Value>) -> LinkedList<Value> {
    
    var prev: Node<Value>? = nil
    var current = list.head
    var next: Node<Value>? = nil

    while current?.next != nil {
        next = current?.next
        current?.next = prev
        prev = current
        current = next
    }
    
    list.head = current
    
    return list
}

func middleNode<Value>(list: inout LinkedList<Value>) -> Node<Value>? {
    if list.head == nil { return nil }
    
    var slow = list.head
    var fast = list.head
    
    while fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
    }
    
    return slow
}

print(middleNode(list: &ll)?.value)
//reverseList(list: &ll)

print(ll.head?.value)




// Define a struct to represent an edge
struct Edge {
    let node: Int
    let weight: Int
}

// Number of Distinct Islands
func noOfDistinctIslands(graph: [[Int]]) -> Int {
    let land = 1
    var noOfCols = graph[0].count
    var noOfRows = graph.count
    var visitedGraph = Array(repeating: Array(repeating: false, count: noOfCols), count: noOfRows)
    var distinctIslands = Set<[[Int]]>()
    var dPoints = [(-1, 0), (0, 1), (1, 0), (0, -1)]
    for row in 0..<noOfRows {
        for col in 0..<noOfCols {
            if graph[row][col] == land, !visitedGraph[row][col] {
                var map: [[Int]] = []
                dfs(row: row, col: col, bRow: row, bCol: col, map: &map)
                distinctIslands.insert(map)
            }
        }
    }
    
    func dfs(row: Int, col: Int, bRow: Int, bCol: Int, map: inout [[Int]]) {
        visitedGraph[row][col] = true
        var diffRow = bRow - row
        var diffCol = bCol - col
        
        map.append([diffRow, diffCol])
        
        for dPoint in dPoints {
            let dRow = row + dPoint.0
            let dCol = col + dPoint.1
            
            if dRow >= 0, dRow < noOfRows, dCol >= 0, dCol < noOfCols, graph[dRow][dCol] == land, !visitedGraph[dRow][dCol] {
                dfs(row: dRow, col: dCol, bRow: bRow, bCol: bCol, map: &map)
            }
        }
    }
    
    return distinctIslands.count
}

noOfDistinctIslands(graph: [
    [1, 1, 0, 0, 0],
    [1, 0, 0, 1, 1],
    [1, 0, 0, 1, 0],
    [0, 0, 0, 1, 0]
])
// Number of enclaves
// Objective is to go through borders first, find land there and its connected land, mark them visited
// Once it is completed, iterate through graph and look for non visited land
// https://www.youtube.com/watch?v=rxKcepXQgU4&list=PLgUwDviBIf0oE3gA41TKO2H5bHpPd7fzn&index=15
func noOfEnclave(graph: [[Int]]) -> Int {
    let land = 1
    var newGraph = graph
    let noOfRows = graph.count
    let noOfCols = graph[0].count
    var visitedGraph = Array(repeating: Array(repeating: false, count: noOfCols), count: noOfRows)
    let dPoints = [(-1, 0), (0, 1), (1, 0), (0, -1)]
    var queue: [(Int, Int)] = []
    
    // Check for land in 1st and last row
    for col in 0..<noOfCols {
        if newGraph[0][col] == land, !visitedGraph[0][col] {
            visitedGraph[0][col] = true
            queue.append((0, col))
        }
        
        let row = noOfRows-1
        
        if newGraph[row][col] == land, !visitedGraph[row][col] {
            visitedGraph[row][col] = true
            queue.append((row, col))
        }
    }
    
    // Now check for land in 1st and last col
    for row in 0..<noOfRows {
        if newGraph[row][0] == land, !visitedGraph[row][0] {
            visitedGraph[row][0] = true
            queue.append((row, 0))
        }
        
        let col = noOfCols-1
        
        if newGraph[row][col] == land, !visitedGraph[row][col] {
            visitedGraph[row][col] = true
            queue.append((row, col))
        }
    }
    
    while !queue.isEmpty {
        let location = queue.removeFirst()
        
        for dPoint in dPoints {
            let dRow = location.0 + dPoint.0
            let dCol = location.1 + dPoint.1
            
            if dRow >= 0, dRow < noOfRows, dCol >= 0, dCol < noOfCols, newGraph[dRow][dCol] == land, !visitedGraph[dRow][dCol] {
                visitedGraph[dRow][dCol] = true
                queue.append((dRow, dCol))
            }
            
        }
    }
    
    var noOfEnclave = 0
    
    for row in 0..<noOfRows {
        for col in 0..<noOfCols {
            if newGraph[row][col] == land, !visitedGraph[row][col] {
                noOfEnclave += 1
            }
        }
    }
    return noOfEnclave
}

noOfEnclave(graph: [
    [0, 0, 0, 0],
    [1, 0, 1, 0],
    [0, 1, 1, 0],
    [0, 0, 0, 0]
])

noOfEnclave(graph: [
    [0, 0, 0, 1],
    [0, 1, 1, 0],
    [0, 1, 1, 0],
    [0, 0, 0, 1],
    [0, 1, 1, 0]
])

noOfEnclave(graph: [
    [0, 0, 1, 1],
    [0, 1, 1, 0],
    [0, 1, 1, 0],
    [0, 0, 0, 1],
    [0, 1, 1, 0]
])

// Replace O's with X's
// https://www.youtube.com/watch?v=BtdgAys4yMk&list=PLgUwDviBIf0oE3gA41TKO2H5bHpPd7fzn&index=14
func replaceOX(graph: [[String]]) {
    let oh = "O"
    var newGraph = graph
    let noOfRows = graph.count
    let noOfCols = graph[0].count
    var visitedGraph = Array(repeating: Array(repeating: false, count: noOfCols), count: noOfRows)
    let dPoints = [(-1, 0), (0, 1), (1, 0), (0, -1)]
    // Check for O in First and Last row
    for col in 0..<noOfCols {
        if newGraph[0][col] == oh && !visitedGraph[0][col] {
            dfs(row: 0, col: col)
            print("(0, \(col))")
        }
        
        if newGraph[noOfRows-1][col] == oh && !visitedGraph[noOfRows-1][col] {
            dfs(row: noOfRows-1, col: col)
            print("(\(noOfRows-1), \(col))")
        }
    }
    
    // Check for O in First and Last col
    for row in 0..<noOfRows {
        if newGraph[row][0] == oh && !visitedGraph[row][0] {
            dfs(row: row, col: 0)
            print("(\(row), 0)")
        }
        
        if newGraph[row][noOfCols-1] == oh && !visitedGraph[row][noOfCols-1] {
            dfs(row: row, col: noOfCols-1)
            print("(\(row), \(noOfCols-1)")
        }
    }
    
    for row in 0..<noOfRows {
        for col in 0..<noOfCols {
            if newGraph[row][col] == oh && !visitedGraph[row][col] {
                newGraph[row][col] = "X"
            }
        }
    }
    
    
    func dfs(row: Int, col: Int) {
        visitedGraph[row][col] = true
        
        for dPoint in dPoints {
            let dRow = row + dPoint.0
            let dCol = col + dPoint.1
            
            if dRow >= 0, dRow < noOfRows, dCol >= 0, dCol < noOfCols, newGraph[dRow][dCol] == oh, !visitedGraph[dRow][dCol] {
                dfs(row: dRow, col: dCol)
            }
        }
    }
    
    for line in newGraph {
        print(line)
    }
}

replaceOX(graph: [["X", "X", "X", "X"], 
                  ["X", "O", "X", "X"],
                  ["X", "O", "O", "X"],
                  ["X", "O", "X", "X"],
                  ["X", "X", "O", "O"]])

// https://www.youtube.com/watch?v=edXdVwkYHF8&list=PLgUwDviBIf0oE3gA41TKO2H5bHpPd7fzn&index=13
func nearest(graph: [[Int]]) {
    var newGraph = graph
    let noOfRows = graph.count
    let noOfCols = graph[0].count
    var visitedGraph = Array(repeating: Array(repeating: false, count: noOfCols), count: noOfRows)
    var queue: [(Int, Int, Int)] = []
    let dPoints = [(-1, 0), (0, 1), (1, 0), (0, -1)]
    
    for i in 0..<noOfRows {
        for j in 0..<noOfCols {
            if graph[i][j] == 1 {
                visitedGraph[i][j] = true
                queue.append((i,j,0))
                print((i,j,0))
            }
        }
    }
    
    while !queue.isEmpty {
        let cell = queue.removeFirst()
        newGraph[cell.0][cell.1] = cell.2
        
        for dPoint in dPoints {
            let dRow = cell.0 + dPoint.0
            let dCol = cell.1 + dPoint.1
            if dRow >= 0 && dRow < noOfRows && dCol >= 0 && dCol < noOfCols && !visitedGraph[dRow][dCol] && newGraph[dRow][dCol] == 0 {
                queue.append((dRow, dCol, cell.2 + 1))
                print((dRow, dCol, cell.2 + 1))
                visitedGraph[dRow][dCol] = true
            }
        }
    }
    
    print(newGraph)
}
//nearest(graph: [[0,1,1,0], [1,1,0,0], [0,0,1,1]])
nearest(graph: [[1,0,1], [1,1,0], [1,0,0]])

//https://www.youtube.com/watch?v=BPlrALf1LDU&list=PLgUwDviBIf0oE3gA41TKO2H5bHpPd7fzn&index=11
func isCycle(adjList: [[Int]], n: Int) -> Bool {
    
    var visitedNodes = Array(repeating: false, count: n)
    var queue: [(Int, Int)] = []
    
    for i in 0..<n {
        if !visitedNodes[i] {
            if bfs(node: i, parent: -1) {
                return true
            }
        }
    }
    
    func bfs(node: Int, parent: Int) -> Bool {
        visitedNodes[node] = true
        queue.append((node, parent))
        
        while !queue.isEmpty {
            let currentNode = queue.removeFirst()
            for node in adjList[currentNode.0] {
                if !visitedNodes[node] {
                    visitedNodes[currentNode.0] = true
                    queue.append((node, currentNode.0))
                } else if currentNode.1 != node {
                    return true
                }
            }
        }
        return false
    }
    return false
}

isCycle(adjList: [[1], [0,2,4], [1,3], [2,4], [1,3]], n: 5)
isCycle(adjList: [[], [2,3], [1,3], [1,2]], n: 4)
//https://www.youtube.com/watch?v=yf3oUhkvqA0&list=PLgUwDviBIf0oE3gA41TKO2H5bHpPd7fzn&index=10
func rottenOranges(bucket: [[Int]]) -> Int {
    var newBucket = bucket
    var noOfCols = bucket[0].count
    var noOfRows = bucket.count
    var visitedOranges = Array(repeating: Array(repeating: false, count: noOfCols), count: noOfRows)
    let dPoints = [(-1, 0), (0, 1), (1, 0), (0, -1)]
    var freshOranges = 0
    var rottenOranges = 0
    var queue: [(Int, Int, Int)] = []
    var maxTime = 0
    
    for row in 0..<noOfRows {
        for col in 0..<noOfCols {
            if bucket[row][col] == 2 {
                queue.append((row, col, 0))
                visitedOranges[row][col] = true
            }
            
            if bucket[row][col] == 1 {
                freshOranges += 1
            }
        }
    }
    
    while !queue.isEmpty {
        let orange = queue.removeFirst()
        let row = orange.0
        let col = orange.1
        let time = orange.2
        maxTime = max(maxTime, time)
        
        for dPoint in dPoints {
            let dRow = row + dPoint.0
            let dCol = col + dPoint.1
            
            if dRow >= 0 && dRow < noOfRows && dCol >= 0 && dCol < noOfCols && !visitedOranges[dRow][dCol] && newBucket[dRow][dCol] == 1 {
                newBucket[dRow][dCol] = 2
                visitedOranges[dRow][dCol] = true
                queue.append((dRow, dCol, time+1))
                rottenOranges += 1
            }
        }
    }
    
    if rottenOranges != freshOranges {
        return -1
    }

    return maxTime
}

//rottenOranges(bucket: [[0,1,2], [0,1,0], [2,1,0]])
//rottenOranges(bucket: [[0,1,2], [0,1,1], [2,1,1]])
//rottenOranges(bucket: [[0,1,2], [0,1,2], [2,1,1]])
rottenOranges(bucket: [[1,2,1], [1,1,0], [0,0,1]])

// MARK: G9 Flood Fill https://www.youtube.com/watch?v=C-2_uSRli8o&list=PLgUwDviBIf0oE3gA41TKO2H5bHpPd7fzn&index=9
func floodFill(image: [[Int]], sr: Int, sc: Int, newColor: Int) {
    var initialColor = image[sr][sc]
    var newImage = image
    var noOfCols = image[0].count
    var noOfRows = image.count
    var visitedImage = Array(repeating: Array(repeating: false, count: noOfCols), count: noOfRows)
    let dPoints = [(-1, 0), (0, 1), (1, 0), (0, -1)]
    
    dfs(row: sr, col: sc)
    
    func dfs(row: Int, col: Int) {
        visitedImage[row][col] = true
        newImage[row][col] = newColor
     
        for dPoint in dPoints {
            let dRow = row + dPoint.0
            let dCol = col + dPoint.1
            
            if dRow >= 0 && dRow < noOfRows && dCol >= 0 && dCol < noOfCols && !visitedImage[dRow][dCol] && newImage[dRow][dCol] == initialColor {
                dfs(row: dRow, col: dCol)
            }
        }
    }
    
    print(newImage)
}

floodFill(image: [[0,1,1,1,0,0,0], [0,0,1,1,0,1,0]], sr: 0, sc: 2, newColor: 5)

// MARK: G8 Number of Islands https://www.youtube.com/watch?v=muncqlKJrH0&list=PLgUwDviBIf0oE3gA41TKO2H5bHpPd7fzn&index=8
func numOfIslands(graph: [[Int]]) -> Int {
    var noOfRows = graph.count
    var noOfCols = graph[0].count
    
    var noOfIslands = 0
    var queue: [(Int, Int)] = []
    
    // Create a visited graph
    var visitedGraph = Array(repeating: Array(repeating: false, count: noOfCols), count: noOfRows)
    
    // Traverse through the graph to find not visited lands
    for row in 0..<noOfRows {
        for col in 0..<noOfCols {
            if !visitedGraph[row][col] && graph[row][col] == 1 {
                bfs(row: row, col: col)
                noOfIslands+=1
            }
        }
    }
    
    // Create bfs
    func bfs(row: Int, col: Int) {
        visitedGraph[row][col] = true
        queue.append((row, col))
        
        while !queue.isEmpty {
            let location = queue.removeFirst()
            // look for all its not visited land neighbours
            for dX in -1...1 {
                for dY in -1...1 {
                    let dRow = location.0 + dX
                    let dCol = location.1 + dY
                    if dRow > -1 && dRow < noOfRows && dCol > -1 && dCol < noOfCols && !visitedGraph[dRow][dCol] && graph[dRow][dCol] == 1 {
                        queue.append((dRow, dCol))
                        visitedGraph[dRow][dCol] = true
                    }
                }
            }
        }
    }
    
    return noOfIslands
}

numOfIslands(graph: [[0,1],[1,0],[1,1],[1,0]])
//numOfIslands(graph: [[0,1,1,1,0,0,0], [0,0,1,1,0,1,0]])
// MARK: G7 DFS https://bit.ly/3yR3dIB
func numOfProvinces(n: Int, edges: [[Int]]) -> Int {
    // Create an adjacency list to represent the graph
    var adjacencyList: [[Edge]] = Array(repeating: [], count: n)
    
    // Populate the adjacency list with the given edges
    for edge in edges {
        let fromNode = edge[0]
        let toNode = edge[1]
        let weight = edge[2]
        
        adjacencyList[fromNode].append(Edge(node: toNode, weight: weight))
    }
    
    // Initialise the numOfProvinces result, visited nodes
    var numOfProvinces = 0
    var visitedNodes = Array(repeating: false, count: n)
    
    for i in 0..<n {
        if !visitedNodes[i] {
            numOfProvinces += 1
            recursion(node: i)
        }
    }
    
    func recursion(node: Int) {
        visitedNodes[node] = true
        
        for adjacencyNode in adjacencyList[node] {
            if !visitedNodes[adjacencyNode.node] {
                recursion(node: adjacencyNode.node)
            }
        }
        
        
    }
    
    return numOfProvinces
}

numOfProvinces(n: 4, edges: [[0,1,2], [1,2,2], [2,3,2]])

// MARK: G6 DFS https://www.youtube.com/watch?v=Qzf1a--rhp8&t=112s
func dfs(n: Int, m: Int, edges: [[Int]]) -> [Int] {
    // Create an adjacency list to represent the graph
    var adjacencyList: [[Edge]] = Array(repeating: [], count: n)
    
    // Populate the adjacency list with the given edges
    for edge in edges {
        let fromNode = edge[0]
        let toNode = edge[1]
        let weight = edge[2]
        
        adjacencyList[fromNode].append(Edge(node: toNode, weight: weight))
    }
    
    // Initialise the DFS result, visited nodes
    var dfsResult: [Int] = []
    var visitedNodes: [Bool] = Array(repeating: false, count: n)
    
    recursion(node: 0)
    
    func recursion(node: Int) {
        visitedNodes[node] = true
        dfsResult.append(node)
        
        for adjacencyNode in adjacencyList[node] {
            if !visitedNodes[adjacencyNode.node] {
                recursion(node: adjacencyNode.node)
            }
        }
    }
    
    return dfsResult
}

print(dfs(n: 4, m: 0, edges: [[0,1,2], [0,2,2], [1,3,2], [2,3,2]]))

// MARK: ADJ NODES
func createAdjNodes(n: Int, m: Int, edges: [[Int]]) -> [[(node: Int, weight: Int)]] {
    var adjNodes: [[(node: Int, weight: Int)]] = Array(repeating: [], count: n)
    
    for edge in edges {
        let node = edge[0]
        let adjNode = edge[1]
        let weight = edge[2]
        
        adjNodes[node].append((node: node, weight: weight))
//        adjNodes[adjNode].append((node: node, weight: weight)) // If bidirectional
    }
    return adjNodes
}


//createAdjNodes(n: 5, m: 3, edges: [[1,2,5]])

// MARK: G5 BFS
// Define a struct to represent an edge
//struct Edge {
//    let node: Int
//    let weight: Int
//}

func bfs(n: Int, m: Int, edges: [[Int]]) -> [Int] {
    // Create an adjacency list to represent the graph
    var adjacencyList: [[Edge]] = Array(repeating: [], count: n)
    
    // Populate the adjacency list with the given edges
    for edge in edges {
        let fromNode = edge[0]
        let toNode = edge[1]
        let weight = edge[2]
        
        adjacencyList[fromNode].append(Edge(node: toNode, weight: weight))
    }
    
    // Initialize the BFS result, the queue of nodes to visit, and the array of visited nodes
    var bfsResult: [Int] = []
    var nodesToVisit: [Int] = []
    var visitedNodes: [Bool] = Array(repeating: false, count: n)
    
    // Start the BFS from node 0
    visitedNodes[0] = true
    nodesToVisit.append(0)
    
    // While there are still nodes to visit...
    while !nodesToVisit.isEmpty {
        // Dequeue a node and add it to the BFS result
        let currentNode = nodesToVisit.removeFirst()
        bfsResult.append(currentNode)
        
        // For each adjacent node...
        for edge in adjacencyList[currentNode] {
            // If the adjacent node has not been visited yet...
            if !visitedNodes[edge.node] {
                // Enqueue the adjacent node and mark it as visited
                nodesToVisit.append(edge.node)
                visitedNodes[edge.node] = true
            }
        }
    }
    
    // Return the BFS result
    return bfsResult
}

print(bfs(n: 4, m: 0, edges: [[0,1,2], [0,2,2], [1,3,2], [2,3,2]]))

