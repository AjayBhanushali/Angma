// L14: https://www.youtube.com/watch?v=i05Ju7AftcM&list=PLgUwDviBIf0rGlzIn_7rsaR2FQ5e6ZOL9&index=14

// MARK: Pseudo Code Recursion

func graphColors(nC: Int, n: Int, graph: [[Int]]) -> Bool {
    var colors = Array(repeating: 0, count: n)
    
    func isSafe(color: Int, vIndex: Int) -> Bool {
        for node in graph[vIndex] {
            if colors[node] == color {
                return false
            }
        }
        return true
    }
    
    func recursion(vIndex: Int) -> Bool {
        
        if vIndex == n {
            return true
        }
        
        for color in 1...nC {
            if isSafe(color: color, vIndex: vIndex) {
                colors[vIndex] = color
                print(colors)
                if recursion(vIndex: vIndex+1) {
                    return true
                }
                colors[vIndex] = 0
            }
        }
        
        return false
    }
    
    return recursion(vIndex: 0)
}

graphColors(nC: 3, n: 4, graph: [[0,1], [1,2], [2,3], [3,0], [0,2]])

// MARK: Pseudo

// 0--1
// |\/
// 2--3

// Colors: A0,B1,C2

// ["A","B","C","A"]


// c=A, ind=0


func graphColorsBF(nC: Int, n: Int, graph: [[Int]]) -> Bool {
    
    var colors =  Array(repeating: -1, count: n)
    var blank: [Int] = []
    var neighbours = Array(repeating: blank, count: n)
    
    for vertex in graph {
        neighbours[vertex[0]].append(vertex[1])
        neighbours[vertex[1]].append(vertex[0])
    }
    
    print(neighbours)
    
    func isItSafe(node: Int, color: Int) -> Bool {
        for neiNode in neighbours[node] {
            if colors[neiNode] == color {
                return false
            }
        }
        return true
    }
    
//    func isItSafe(node: Int, color: Int) -> Bool {
//        for vertex in graph {
//            if vertex[0] == node {
//                if colors[vertex[1]] == color {
//                    return false
//                }
//            } else if vertex[1] == node {
//                if colors[vertex[0]] == color {
//                    return false
//                }
//            }
//        }
//        return true
//    }
    
//    for node in 0..<n {
//        var isSafe = false
//        for color in 0..<nC {
//            print(node, color)
//            if isItSafe(node: node, color: color) {
//                colors[node] = color
//                isSafe = true
//                break
//            }
//        }
//        if !isSafe {
//            return false
//        }
//    }
//    return true
    
    
    func recursion(node: Int) -> Bool {

        if node == n {
            return true
        }

        for color in 0..<nC {
            if isItSafe(node: node, color: color) {
                colors[node] = color
                return recursion(node: node+1)
            }
        }
        return false
    }
    return recursion(node: 0)
}

graphColorsBF(nC: 3, n: 4, graph: [[0,1], [1,2], [2,3], [3,0], [0,2]])

graphColorsBF(nC: 2, n: 3, graph: [[0,1], [1,2], [0,2]])

//0-1
//|/
//2

// f(0) A
// f(1) B
// f(2)
