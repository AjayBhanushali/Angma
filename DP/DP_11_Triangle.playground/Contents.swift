// DP_11: https://www.youtube.com/watch?v=SrP-PiLSYC0&list=PLgUwDviBIf0qUlt5H_kiKYaNSqJ81PMMY&index=12

// MARK: Problem > Trianle
// MARK: Pseudo code > Recursion + Memoization
// MARK: Tabulization + Space Optimization >


// MARK: Pseudo code > Recursion + Memoization
// MARK: Note: If we notice, destination has variable columns. Whereas, starting point is constant, Hence in this case we will start recursion from the constant which is first location.

// Our approach is to get the minimum values of next two locations. so that we can find the minimum value for the current location.

// Call the recursion for the first location
// Inside recursion
// Base condition:
// If location is outside then return 0
// for loop for rows
// inside find the downSum and dowmDiagSum(means call recursion for them)
// return min of both

func triangle(_ triangle: [[Int]]) -> Int {
    
    var memo = Array(repeating: Array(repeating: -1, count: triangle.count), count: triangle.count)
    
    func recursion(i: Int, j: Int) -> Int {
        
        if i == triangle.count-1 {
            return triangle[i][j]
        }
        
        if memo[i][j] != -1 {
            return memo[i][j]
        }
        
        var downSum = triangle[i][j] + recursion(i: i+1, j: j)
        var downDiagonal = triangle[i][j] + recursion(i: i+1, j: j+1)
        
        memo[i][j] = min(downSum, downDiagonal)
        
        return memo[i][j]
    }
    
    return recursion(i: 0, j: 0)
}

//print(triangle([[1], [2,3], [3,6,7], [8,9,6,10]]))

// MARK: Pseudo code > Tabulization + Space Optimization
// As mentioned earlier, variable destinations, constant starting points, we will start from the bottom

func triangleTab(_ triangle: [[Int]]) -> Int {
    
    var previousValues: [Int] = triangle[triangle.count-1]
    
    for i in stride(from: triangle.count-2, through: 0, by: -1) {
        var currentValues: [Int] = Array(repeating: -1, count: i+1)
        
        for j in stride(from: i, through: 0, by: -1) {
            var downSum = triangle[i][j] + previousValues[j]
            var downDiagonal = triangle[i][j] + previousValues[j+1]
            
            currentValues[j] = min(downSum, downDiagonal)
        }
        
        previousValues = currentValues
    }
    print(previousValues)
    return previousValues[0]
}

print(triangleTab([[1], [2,3], [3,6,7], [8,9,6,10]]))

