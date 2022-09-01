//DP_8: https://www.youtube.com/watch?v=sdE0A2Oxofw&list=PLgUwDviBIf0qUlt5H_kiKYaNSqJ81PMMY&index=9

import Darwin

// MARK: Grid Unique Paths
// https://leetcode.com/problems/unique-paths/

/*
 There is a robot on an m x n grid. The robot is initially located at the top-left corner (i.e., grid[0][0]). The robot tries to move to the bottom-right corner (i.e., grid[m - 1][n - 1]). The robot can only move either down or right at any point in time.
 
 Given the two integers m and n, return the number of possible unique paths that the robot can take to reach the bottom-right corner.

 The test cases are generated so that the answer will be less than or equal to 2 * 109.
 
 Input: m = 3, n = 7
 Output: 28
 */

// MARK: Recursion Memoization
// 1. Call the recursion from the last location f(row-1, col-1)
// We have to reach till (r: 0, c: 0) and we can only move in left and up direction. Hence,
// 2. Inside, the recursion
// 3. Base case
// If r == 0 & c == 0 return 1
// if r < 0 & c < 0 return 0
// Recursive Case
// Each location can move in left and up direction. Hence, we have to call recursion in 2 directions and return their sum.
// Memoization
// We can store the result for each visited location in an array which can save recalling recursion for visited locations

//Time Complexity: O(2^(m*n))
//Space Complexity: O(n)

func uniquePaths(r: Int, c: Int) -> Int {
    
    var memo: [[Int]] = Array(repeating: Array(repeating: -1, count: c), count: r)
    
    func recursion(r: Int, c: Int) -> Int {
        
        if r == 0 && c == 0 {
            return 1
        }
        
        if r < 0 || c < 0 {
            return 0
        }
        
        if memo[r][c] != -1 {
            return memo[r][c]
        }
        
        let left = recursion(r: r, c: c-1)
        let up = recursion(r: r-1, c: c)
        
        memo[r][c] = left + up
        
        return memo[r][c]
    }
    
    return recursion(r: r-1, c: c-1)
}

uniquePaths(r: 3, c: 3)


// MARK: Tabulazation

func uniquePathsM(r: Int, c: Int) -> Int {
    var r = r
    var c = c
    if c > r {
        let t = r
        r = c
        c = r
    }
    
    var lastRow = Array(repeating: 0, count: c)
    
    for r in 0..<r {
        var newRow = Array(repeating: 0, count: c)
        for c in 0..<c {
            if r == 0 && c == 0 {
                newRow[c] = 1
                continue
            }
            var lastLeft = 0
            if c > 0 {
                lastLeft = newRow[c-1]
            }
            
            var lastUp = 0
            
            if r > 0 {
                lastUp = lastRow[c]
            }
            
            newRow[c] = lastLeft + lastUp
        }
        lastRow = newRow
    }
    
    return lastRow[c-1]
}

uniquePathsM(r: 3, c: 2)

// DP_9: https://www.youtube.com/watch?v=TmhpgXScLyY&list=PLgUwDviBIf0qUlt5H_kiKYaNSqJ81PMMY&index=10
// https://leetcode.com/problems/unique-paths-ii/

/*
 You are given an m x n integer array grid. There is a robot initially located at the top-left corner (i.e., grid[0][0]). The robot tries to move to the bottom-right corner (i.e., grid[m-1][n-1]). The robot can only move either down or right at any point in time.

 An obstacle and space are marked as 1 or 0 respectively in grid. A path that the robot takes cannot include any square that is an obstacle.

 Return the number of possible unique paths that the robot can take to reach the bottom-right corner.

 The testcases are generated so that the answer will be less than or equal to 2 * 109.
 */

//MARK: Unique Paths II

// MARK: Recursion + Memoization

// MARK: Recursion Memoization
// 1. Call the recursion from the last location f(row-1, col-1)
// We have to reach till (r: 0, c: 0) and we can only move in left and up direction. Hence,
// 2. Inside, the recursion
// 3. Base case
// if grid[r][c] == -1 return 0
// If r == 0 & c == 0 return 1
// if r < 0 & c < 0 return 0
// Recursive Case
// Each location can move in left and up direction. Hence, we have to call recursion in 2 directions and return their sum.
// Memoization
// We can store the result for each visited location in an array which can save recalling recursion for visited locations

//Time Complexity: O(2^(m*n))
//Space Complexity: O(n)


func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
    let r = obstacleGrid.count
    let c = obstacleGrid[r-1].count
    
    var memo = Array(repeating: Array(repeating: -1, count: c), count: r)
    
    func recursion(r: Int, c: Int) -> Int {
        if r < 0 || c < 0 {
            return 0
        }
        
        if memo[r][c] != -1 {
            return memo[r][c]
        }
        
        if obstacleGrid[r][c] == 1 {
            return 0
        }
        
        if r == 0 && c == 0 {
            return 1
        }
        
        memo[r][c] = recursion(r: r, c: c-1) + recursion(r: r-1, c: c)
        return memo[r][c]
    }
    
    return recursion(r: r-1, c: c-1)
}

uniquePathsWithObstacles([[0,0,0],[0,1,0],[0,0,0]])

// MARK: unique Paths 2 Tabulization
func uniquePathsWithObstaclesTabulization(_ obstacleGrid: [[Int]]) -> Int {
    let rows = obstacleGrid.count
    let cols = obstacleGrid[rows-1].count
    var lastRow = Array(repeating: 0, count: cols)
    
    for r in 0..<rows {
        var newRow = Array(repeating: 0, count: cols)
        for c in 0..<cols {
            if r == 0 && c == 0 {
                newRow[0] = 1
                continue
            }
            
            if obstacleGrid[r][c] == 1 {
                newRow[c] = 0
                continue
            }
            
            var left = 0
            
            if c > 0 {
                left = newRow[c-1]
            }
            
            var up = 0
            
            if r > 0 {
                up = lastRow[c]
            }
            
            newRow[c] = left + up
        }
        lastRow = newRow
    }
    
    return lastRow[cols-1]
}

//uniquePathsWithObstaclesTabulization([[0,0,0],[0,1,0],[0,0,0]])

