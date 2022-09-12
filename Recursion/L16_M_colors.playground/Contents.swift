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

//graphColors(nC: 3, n: 4, graph: [[0,1], [1,2], [2,3], [3,0], [0,2]])
graphColors(nC: 2, n: 3, graph: [[0,1], [1,2], [0,2]])
