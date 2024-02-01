import Foundation

// Define a struct to represent an edge
struct Edge {
    let node: Int
    let weight: Int
}

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

