// DP_14:
// Problem Link:

// MARK: Pseudo code > Recursion + Memoization
// Approach: Top to Bottom
// We will call recursion for the last index and the target value
// NOTE: DP[rows will be number array's count][but target colums would be target + 1] because we have to maintain the ans for target as well in the DP

// In Recursion,
// Base Case
// If target == 0 return set DP[ind][target] = 1 and return TRUE
// If ind = 0 return array[ind] == target // cannot iterate further hence

// Recursion Case
// untake = recursion(ind-1, target) // Meaning that we are looking for more possibilities other than the current array
// take = false
// take only if target >= array[ind], take = recursion(ind-1, target-array[ind])
// return take || untake


func subsetSumToK(_ array: [Int], k: Int) -> Bool {
    
    var dp = Array(repeating: Array(repeating: -1, count: k+1), count: array.count)
    
    func recursion(ind: Int, target: Int) -> Bool {
        
        // Base Case
        if target == 0 {
            return true
        }
        
        if ind == 0 { return array[ind] == target }
        
        if dp[ind][target] != -1 { return dp[ind][target] == 1 }
        
        let unTake = recursion(ind: ind-1, target: target)
        var take = false
        if target >= array[ind] {
            take = recursion(ind: ind-1, target: target-array[ind])
        }
        
        dp[ind][target] = (take || unTake) ? 1 : 0
        return (take || unTake)
    }
    let result = recursion(ind: array.count-1, target: k)
    return result
}

//print(subsetSumToK([2,3,1,1], k: 4))

// MARK: Pseudo code > Tabulization + Space Optimization
// Approach: Bottom to Top // reverse the logic of Rec+Memo
// Set the base PreviousDP
// If we notice, when target == 0 DP should store it as TRUE
// Also, for 0th index, if target == array[index], set it as TRUE
// We have created the previous
// Now, we have to iterate for each rows and each target other than 0
// Inside iteration we have to keep follow the same logic of Rec+Memo
// untake = previous[target]
// then if the target >= array[ind], take = previous[target-array[ind]]
// set current = take || untake
// out loop of target
// set previous = current
// out loop of ind
// return previousDP[k]

func subsetSumToKTab(_ array: [Int], k: Int) -> Bool {
    
    var previousDP = Array(repeating: false, count: k+1)
    
    previousDP[0] = true
    previousDP[array[0]] = true
    
    for ind in 1..<array.count {
        var currentDP = Array(repeating: false, count: k+1)
        currentDP[0] = true
        for target in 1...k {
            let unTake = previousDP[target]
            var take = false
            if target >= array[ind] {
                take = previousDP[target-array[ind]]
            }
            currentDP[target] = take || unTake
        }
        previousDP = currentDP
    }
    
    return previousDP[k]
}

//print(subsetSumToKTab([2,3,1,1], k: 4))

func deleteFloors(array: [Int]) -> Int {
    var minDeleted = Int.max
    
    for current in array {
        var currentDeleted = 0
        for i in 0..<array.count {
            if current > array[i] {
                currentDeleted += array[i]
            } else {
                currentDeleted += array[i] - current
            }
            if currentDeleted > minDeleted {
                break
            }
        }
        print(currentDeleted)
        minDeleted = min(minDeleted, currentDeleted)
    }
    
    return minDeleted
}

//print(deleteFloors(array: [3,5,7]))
print(deleteFloors(array: [7,8,10]))
