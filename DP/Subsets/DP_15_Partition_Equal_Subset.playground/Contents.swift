// DP_15: https://www.youtube.com/watch?v=fWX9xDmIzRI&list=PLgUwDviBIf0qUlt5H_kiKYaNSqJ81PMMY&index=15
// Problem Link: https://bit.ly/3ukNmRZ

/*
 You are given an array 'ARR' of 'N' positive integers. Your task is to find if we can partition the given array into two
 subsets such that the sum of elements in both subsets is equal.
 For example, let's say the given array is [2, 3, 3, 3, 4, 5], then the array can be partitioned as [2, 3, 51, and [3, 3, 4] with equal sum 10
 */

// MARK: Pseudo code > Recursion + Memoization
// Approach: Top to Bottom
// Find sum of all elements. Lets name it total
// if total is odd then we cannot find equal target 2 subsets
// Hence, if total is odd return false
// Now, target should be half of total
// We will call recursion for the last index and the target value
// NOTE: DP[rows will be number array's count][but target colums would be target + 1] because we have to maintain the ans for target as well in the DP

// In Recursion,
// Base Case
// If target == 0, return TRUE
// If ind = 0 return array[ind] == target // cannot iterate further hence

// Recursion Case
// untake = recursion(ind-1, target) // Meaning that we are looking for more possibilities other than the current array
// take = false
// take only if target >= array[ind], take = recursion(ind-1, target-array[ind])
// set dp[ind][target] = (take || untake) ? 1 : 0
// return take || untake

func canPartition(_ array: [Int]) -> Bool {
    
    let total = array.reduce(0, +)
    
    if total%2 != 0 {
        return false
    }
    
    let target = total/2
    
    var dp = Array(repeating: Array(repeating: -1, count: target+1), count: array.count)
    
    func recursion(ind: Int, target: Int) -> Bool {
        
        if target == 0 { return true }
        
        if ind == 0 {
            return target == array[ind]
        }
        
        if dp[ind][target] != -1 {
            return dp[ind][target] == 1
        }
        
        let untake = recursion(ind: ind-1, target: target)
        
        var take = false
        if target >= array[ind] {
            take = recursion(ind: ind-1, target: target-array[ind])
        }
        
        dp[ind][target] = (take || untake) ? 1 : 0
        
        return take || untake
    }
    
    return recursion(ind: array.count-1, target: target)
}

print(canPartition([2, 3, 3, 3, 4, 5]))

// MARK: Pseudo code > Tabulization + Space Optimization
// Approach: Bottom to Top // reverse the logic of Rec+Memo
// Find sum of all elements. Lets name it total
// if total is odd then we cannot find equal target 2 subsets
// Hence, if total is odd return false
// Tabulization
// Set the base PreviousDP for targets 0
// First element of previousDP will be stored as TRUE
// Also, previuosDP[array[0]] will be stored as TRUE. WHY? means if target is array[0], so set it as TRUE only if it is less than the target

// Iterate for each ind and target in ascending order other than 0
// inside ind iteration
// create a new currentDP[0] == true
// inside target 1 to target iteration
// repeat the same logic of rec+memo
// outside for target loop
// set previousDP = currentDP
// outside ind loop
// return previousDP.last

func canPartitionTab(_ array: [Int]) -> Bool {
    let total = array.reduce(0, +)
    
    if total%2 != 0 {
        return false
    }
    
    let k = total/2
    
    var previousDP = Array(repeating: false, count: k+1)
    
    previousDP[0] = true
    if array[0] <= k { previousDP[array[0]] = true }
    
    for ind in 1..<array.count {
        var currentDP = Array(repeating: false, count: k+1)
        currentDP[0] = true
        
        for target in 1...k {
            let untake = previousDP[target]
            var take = false
            
            if target >= array[ind] {
                take = previousDP[target-array[ind]]
            }
            
            currentDP[ind] = take || untake
        }
        previousDP = currentDP
    }
    
    return previousDP[k]
}

print(canPartition([2, 3, 3, 3, 4, 6]))
