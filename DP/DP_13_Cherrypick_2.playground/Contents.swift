// DP_13: https://www.youtube.com/watch?v=N_aJ5qQbYA0&list=PLgUwDviBIf0qUlt5H_kiKYaNSqJ81PMMY&index=13
// Problem Link: https://bit.ly/3KQELfy

// MARK: Pseudo code > Recursion + Memoization
// Approach: Bottom To Top (Because of starting point is fixed)
// Both Ramesh and Suresh are on the same row but on different columns, they have to always move in +1 row with -1,0,+1 cols
// Hence, we can call recursion for both of them using a single method.

// We will call recursion for row=0, rCol=0, sCol=c-1
// Recursion
// Base Case
// 1. Outer bounds condition for cols
// 1.5 Memo Condition: if already visited then return it
// 2. Destination condition: if row = n-1 > if rCol = sCol, return grid[row][rCol], else return grid[row][rCol] + grid[row][sCol]

// Recursive Case:
// We have to maintain max
// Iterate for each possible scenario
// Inside iteration
// create currentValue
// if rCol == sCol
// currentValue = grid[row][rCol]
// else
// currentValue = grid[row][rCol] + grid[row][sCol]
// then, currentValue += recursion for next row, next rCol, next sCol
// then, set max
// outside Iteration, set max in memo, return max

func cherryPickup2(_ grid: [[Int]]) -> Int {
    
    let cols = grid[0].count
    var memo = Array(repeating: Array(repeating: Array(repeating: -1, count: cols), count: cols), count: grid.count)
    
    func recursion(row: Int, rCol: Int, sCol: Int) -> Int {
        // Base Case
        if rCol < 0 || rCol >= cols || sCol < 0 || sCol >= cols {
            return 0
        }
        
        if memo[row][rCol][sCol] != -1 {
            return memo[row][rCol][sCol]
        }
        
        if row == grid.count-1 {
            if rCol == sCol {
                return grid[row][rCol]
            } else {
                return grid[row][rCol] + grid[row][sCol]
            }
        }
        
        // Recursion Case
        var maximum = 0
        
        for nrCol in -1...1 {
            for nsCol in -1...1 {
                var currentValue = grid[row][rCol]
                if rCol != sCol {
                    currentValue += grid[row][sCol]
                }
                currentValue += recursion(row: row+1, rCol: rCol+nrCol, sCol: sCol+nsCol)
                maximum = max(maximum, currentValue)
            }
        }
        
        memo[row][rCol][sCol] = maximum
        
        return maximum
    }
    
    return recursion(row: 0, rCol: 0, sCol: grid[0].count-1)
}


print(cherryPickup2([[2,3,1,2], [3,4,2,2], [5,6,3,5]]))

// MARK: Pseudo code > Tabulization + Space Optimization
// Approach: Top to Bottom

// We will store all the posible answers for the last row
// then we will iterate from rows-1 to 0
// Inside this iteration repeat the recursion code
// at the end return prevValues[0][colsCount-1]

func cherryPickup2Tab(_ grid: [[Int]]) -> Int {
    
    let rows = grid.count
    let cols = grid[0].count
    
    var prevValues = Array(repeating: Array(repeating: -1, count: cols), count: cols)
    
    for rCol in 0..<cols {
        for sCol in 0..<cols {
            var currentValue = grid[rows-1][rCol]
            if rCol != sCol {
                currentValue += grid[rows-1][sCol]
            }
            prevValues[rCol][sCol] = currentValue
        }
    }
    
    for row in stride(from: rows-2, through: 0, by: -1) {
        var currentValues = Array(repeating: Array(repeating: -1, count: cols), count: cols)
        for rCol in 0..<cols {
            for sCol in 0..<cols {
                var maximum = 0
                for nrCol in -1...1 {
                    for nsCol in -1...1 {
                        var currentValue = grid[row][rCol]
                        if rCol != sCol {
                            currentValue += grid[row][sCol]
                        }
                        
                        if rCol+nrCol >= 0 && rCol+nrCol < cols && sCol+nsCol >= 0 && sCol+nsCol < cols {
                            currentValue += prevValues[rCol+nrCol][sCol+nsCol]
                        }
                        maximum = max(maximum, currentValue)
                    }
                }
                currentValues[rCol][sCol] = maximum
            }
        }
        prevValues = currentValues
    }
    
    return prevValues[0][cols-1]
}

print(cherryPickup2Tab([[2,3,1,2], [3,4,2,2], [5,6,3,5]]))
