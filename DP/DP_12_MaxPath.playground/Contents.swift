// DP_12: https://www.youtube.com/watch?v=N_aJ5qQbYA0&list=PLgUwDviBIf0qUlt5H_kiKYaNSqJ81PMMY&index=13

// MARK: Pseudo code > Recursion + Memoization
// Approach: Top to Bottom
// We have to iterate from each column of the last row
// Find their max using recursion and return the max of all

// In recursion
// Base case: return grid values for row 0 items
// return min for out of index items
// Recursive condition
// find up, upRight, upLeft and return the max

func maxPathSum(_ grid: [[Int]]) -> Int {
    
    var maxValues: [Int] = []
    
    for col in 0..<grid[0].count {
        maxValues.append(recursion(row: grid.count-1, col: col))
    }
    
    var memo = Array(repeating: Array(repeating: -1, count: grid[0].count), count: grid.count)
    
    func recursion(row: Int, col: Int) -> Int {
        /// Base case
        
        if col > grid[0].count-1 || col < 0 {
            return Int.min
        }
        
        if row == 0 {
            return grid[row][col]
        }
        
        /// Recursive case
        let up = grid[row][col] + recursion(row: row-1, col: col)
        let upLeft = grid[row][col] + recursion(row: row-1, col: col-1)
        let upRight = grid[row][col] + recursion(row: row-1, col: col+1)
        
        return max(up, upLeft, upRight)
        
    }
    
    return maxValues.max() ?? 0
}

//print(maxPathSum([[1,2,10,4], [100,3,2,1], [1,1,20,2], [1,2,2,1]]))

func maxPathSumTab(_ grid: [[Int]]) -> Int {
    var prevValues = grid[0]
    
    for row in 1..<grid.count {
        var currentValues: [Int] = []
        for col in 0..<prevValues.count {
            
            let up = grid[row][col] + prevValues[col]
            let upLeft = grid[row][col] + (col > 0 ? prevValues[col-1] : Int.min)
            let upRight = grid[row][col] + (col < prevValues.count-1 ? prevValues[col+1] : Int.min)
            
            currentValues.append(max(up, upLeft, upRight))
        }
        
        prevValues = currentValues
    }
    
    return prevValues.max()!
}

print(maxPathSumTab([[1,2,10,4], [-100,3,2,1], [1,1,20,2], [1,2,2,1]]))
