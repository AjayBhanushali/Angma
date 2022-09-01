// DP_17: https://www.youtube.com/watch?v=ZHyb-A2Mte4&list=PLgUwDviBIf0qUlt5H_kiKYaNSqJ81PMMY&index=18
// Problem Link: https://bit.ly/3B5JBkU

/*
 You are given an array (0-based indexing) of positive integers and you have to tell how many different ways of
 selecting the elements from the array are there such that the sum of chosen elements is equal to the target number
 "tar".
 */

// MARK: Pseudo code > Recursion + Memoization
// Approach: Top to Bottom
// We will call recursion for the last index and the target value
// NOTE: DP[rows will be number array's count][but target colums would be target + 1] because we have to maintain the ans for target as well in the DP

// In Recursion,
// Base Case
// If target == 0, return 1
// If ind = 0 return array[ind] == target return 1 // cannot iterate further hence

// Recursion Case
// untake = recursion(ind-1, target) // Meaning that we are looking for more possibilities other than the current array
// take = false
// take only if target >= array[ind], take = recursion(ind-1, target-array[ind])
// set dp[ind][target] = take + untake
// return take + untake


func findWays(_ array: [Int], target: Int) -> Int {
    var dp = Array(repeating: Array(repeating: -1, count: target+1), count: array.count)
    
    func recursion(ind: Int, target: Int) -> Int {
        
        if ind == 0 {
            if target == 0 && array[0] == 0 { return 2 }
            if target == 0 || array[0] == target { return 1 }
            return 0
        }
        
        
        if dp[ind][target] != -1 {
            return dp[ind][target]
        }
        
        let untake = recursion(ind: ind-1, target: target)
        
        var take = 0
        
        if target >= array[ind] {
            take = recursion(ind: ind-1, target: target - array[ind])
        }
        
        dp[ind][target] = take + untake
        
        return take + untake
    }
    
    return recursion(ind: array.count-1, target: target)
}

print(findWays([1,2,2,3], target: 3))
print(findWays([0,0,1], target: 1))

// MARK: Pseudo code > Tabulization + Space Optimization
// Approach: Bottom to Top // reverse the logic of Rec+Memo
// Tabulization
// Set the base PreviousDP for targets 0
// First element of previousDP will be stored as 1
// Also, previuosDP[array[0]] will be stored as 1. WHY? means if target is array[0], so set it as TRUE only if it is less than the target

// Iterate for each ind and target in ascending order other than 0
// inside ind iteration
// create a new currentDP[0] == 1
// inside target 1 to target iteration
// repeat the same logic of rec+memo
// outside for target loop
// set previousDP = currentDP
// outside ind loop
// return previousDP.last

func findWaysTab(_ array: [Int], k: Int) -> Int {
    
    var previousDP = Array(repeating: 0, count: k+1)
    
    if array[0] == 0 {
        previousDP[0] = 2
    } else {
        previousDP[0] = 1
        if array[0] <= k { previousDP[array[0]] = 1 }
    }
    
    for ind in 1..<array.count {
        var currentDP = Array(repeating: 0, count: k+1)
        currentDP[0] = 1
        
        for target in 0...k {
            let untake = previousDP[target]
            
            var take = 0
            if target >= array[ind] {
                take = previousDP[target-array[ind]]
            }
            
            currentDP[target] = take + untake
        }
        
        previousDP = currentDP
    }

    return previousDP[k]
}

print(findWaysTab([0,0,1], k: 1))
print(findWaysTab([1,2,2,3], k: 3))

