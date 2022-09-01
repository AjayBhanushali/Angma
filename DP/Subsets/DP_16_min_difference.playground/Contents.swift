// DP_16: https://www.youtube.com/watch?v=GS_OqZb2CWc&list=PLgUwDviBIf0qUlt5H_kiKYaNSqJ81PMMY&index=17
// Problem Link: https://bit.ly/3ukNmRZ

/*
 You are given an array containing N non-negative integers. Your task is to partition this array into two subsets such
 that the absolute difference between subset sums is minimum.
 You just need to find the minimum absolute difference considering any valid division of the array elements.
 [1,2,3,4] > Diff > 0
 */

// MARK: Pseudo code > Recursion + Memoization
// Approach: Top to Bottom
// Find sum of all elements. Lets name it total
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

// Call recursion for target in a for loop from target to 0
// Check if we find the solution, if we find it return the difference.

func minSubsetSumDifference(_ array: [Int]) -> Int {
    
    let total = array.reduce(0, +)
    
    let target = total/2
    
    var dp = Array(repeating: Array(repeating: -1, count: target+1), count: array.count)
    
    func recursion(ind: Int, target: Int) -> Bool {
        
        if target == 0 {
            dp[ind][target] = 1
            return true
        }
        
        if ind == 0 {
            if target == array[ind] {
                dp[ind][target] = 1
                return true
            } else {
                dp[ind][target] = 0
                return false
            }
        }
        
        if dp[ind][target] != -1 {
            return dp[ind][target] == 1
        }
        
        let untake = recursion(ind: ind-1, target: target)
        
        var take = false
        
        if target >= array[ind] {
            take = recursion(ind: ind-1, target: target - array[ind])
        }
        
        dp[ind][target] = (take || untake) ? 1 : 0
        
        return take || untake
    }
    
    var minDifference = total
    
    for target in stride(from: target, through: 0, by: -1) {
        if recursion(ind: array.count-1, target: target) {
            let currentMin = abs(target - (total - target))
            minDifference = min(minDifference, currentMin)
            break
        }
    }
    
    print(dp)
    
    return minDifference
}

//print(minSubsetSumDifference([1,2,3,4]))
print(minSubsetSumDifference([8,6,5]))

// MARK: Pseudo code > Tabulization + Space Optimization
// Approach: Bottom to Top // reverse the logic of Rec+Memo
// Find sum of all elements. Lets name it total
// create target = total/2
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

func minSubsetSumDifferenceTab(_ array: [Int]) -> Int {
    
    let total = array.reduce(0, +)
    
    let k = total/2
    
    var previousDP = Array(repeating: false, count: k+1)
    
    previousDP[0] = true
    previousDP[array[0]] = true
    
    for ind in 1..<array.count {
        var currentDP = Array(repeating: false, count: k+1)
        currentDP[0] = true
        
        for target in 1...k {
            let untake = previousDP[target]
            
            var take = false
            if target >= array[ind] {
                take = previousDP[target-array[ind]]
            }
            
            currentDP[target] = take || untake
        }
        print(previousDP)
        previousDP = currentDP
    }
    
    var minDifference = total
    
    for target in stride(from: k, through: 0, by: -1) {
        if previousDP[target] {
            let currentMin = abs(target - (total - target))
            minDifference = min(minDifference, currentMin)
            break
        }
    }
    
    return minDifference
}

print(minSubsetSumDifferenceTab([1,2,3,4]))
//print(minSubsetSumDifferenceTab([8,6,5]))
