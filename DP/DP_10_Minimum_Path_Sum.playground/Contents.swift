// DP_10: https://www.youtube.com/watch?v=_rgTlyky1uQ&list=PLgUwDviBIf0qUlt5H_kiKYaNSqJ81PMMY&index=11

// MARK: Minimum path sum in Grid

// MARK: Recursion
// We will start from the end location
// Our job is to find all the ways to reach till (0,0) location and store the sum of each path
// At the end return the minimum of all path's sum

// MARK: Pseudo code: Recursion + Memoization
// memo[[Int]] to store minimum sum of all location

// Inside Recursion
// Memo Case
// if memo[r][c] != -1 { return memo[r][c] }
// Base case
// if r,c == 0 { return value[r][c] }
// if r,c < 0 { return Int.max }
// Recursion case
// leftSum = currentValue + f(r,c-1)
// upSum = currentValue + f(r-1,c)
// memo[r][c] = min(leftSum, rightSum)
// return memo[r][c]
// End recursion
// return Call recursion for f(r-1,c-1)

func minimumPathSum(grid: [[Int]]) -> Int {
    let rows = grid.count
    let cols = grid[0].count
    var memo = Array(repeating: Array(repeating: -1, count: cols), count: rows)
    
    func recursion(row: Int, col: Int) -> Int {
        // Base case
        if row < 0 || col < 0 {
            return -2
        }
        
        if row == 0 && col == 0 {
            memo[row][col] = grid[row][col]
            return grid[row][col]
        }
        
        // Memo case
        if memo[row][col] != -1 {
           return memo[row][col]
        }
        
        let currentValue = grid[row][col]
        
        let leftSum = currentValue + recursion(row: row, col: col-1)
        let upSum = currentValue + recursion(row: row-1, col: col)
        
        memo[row][col] = min(leftSum, upSum)
        
        if currentValue - leftSum == 2 {
            memo[row][col] = upSum
        }
        
        if currentValue - upSum == 2 {
            memo[row][col] = leftSum
        }
        
        return memo[row][col]
    }
    
    return recursion(row: rows-1, col: cols-1)
}

minimumPathSum(grid: [[5, 9, 6], [11, 5, 2]])

// MARK: Tabulization + Space Optimization

// Create an array prevValues of col count
// We will first set value for preValues(0) to grid[0][0]
// Start for loop for each row
// Create an array currentValues of col count
// start for loop for each col
// if row, col == 0 continue
// leftSum = currentValue + currentValues[r][c-1]
// upSum = currentValue + currentValues[r][c-1]
// currentValues[r][c] = min(leftSum, upSum)
// end for loop cols
// prevValues = currentValues
// end for loop rows
// return prevValues.last

func minimumPathSumTabulization(grid: [[Int]]) -> Int {
    let rows = grid.count
    let cols = grid[0].count
    var prevValues = Array(repeating: -1, count: cols)
    
    prevValues[0] = grid[0][0]
    
    for row in 0..<rows {
        var currentValues = Array(repeating: -1, count: cols)
        for col in 0..<cols {
            
            if row == 0 && col == 0 {
                currentValues[0] = prevValues[0]
                continue
            }
            
            let currentValue = grid[row][col]
            
            if col == 0 {
                currentValues[col] = currentValue + prevValues[col]
                continue
            }
            
            if row == 0 {
                currentValues[col] = currentValue + currentValues[col-1]
                continue
            }
            
            currentValues[col] = currentValue + min(currentValues[col-1], prevValues[col])
        }
        prevValues = currentValues
    }
    
    return prevValues[cols-1]
}

minimumPathSumTabulization(grid: [[5, 9, 6], [11, 5, 2]])
