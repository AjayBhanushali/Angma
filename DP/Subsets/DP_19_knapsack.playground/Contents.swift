// DP_19: https://www.youtube.com/watch?v=GqOmJHQZivw&list=PLgUwDviBIf0qUlt5H_kiKYaNSqJ81PMMY&index=20
// Problem Link: https://bit.ly/3KHpP3v

/*
 A thief is robbing a store and can carry a maximal weight of W into his knapsack. There are N items and the ith item
 weighs wi and is of value vi. Considering the constraints of the maximum weight that a knapsack can carry, you have
 to find and return the maximum value that a thief can generate by stealing items.
 
 Ex:
 5
 [3,2,5]
 [40,30,60]
 Answer: 70
 */

// MARK: Pseudo code > Recursion + Memoization
// Approach: Top to Bottom
// We will call recursion for the last index and the maxWeight
// NOTE: DP[rows will be number array's count][but weights colums would be maxWeight + 1] because we have to maintain the ans for weight 0 as well in the DP

// In Recursion,
// Base Case
// If ind = 0
// if maxWeight >= wt[0] { return wt[0] } else return 0

// Recursion Case
// untake = recursion(ind-1, maxWeight)
// take = 0
// take only if maxWeight >= wt[ind], take = wt[ind] + recursion(ind-1, target-wt[ind])
// set dp[ind][target] = max(take, untake)
// return dp[ind][target]


func knapsack(weights: [Int], values: [Int], bagWeight: Int) -> Int {
    
    var dp = Array(repeating: Array(repeating: -1, count: bagWeight+1), count: weights.count)
    
    func recursion(ind: Int, maxWeight: Int) -> Int {
        
        if ind == 0 {
            return maxWeight >= weights[0] ? values[0] : 0
        }
        
        if dp[ind][maxWeight] != -1 {
            return dp[ind][maxWeight]
        }
        
        let untake = recursion(ind: ind-1, maxWeight: maxWeight)
        
        var take = 0
        
        if maxWeight >= weights[ind] {
            take = values[ind] + recursion(ind: ind-1, maxWeight: maxWeight - weights[ind])
        }
        
        dp[ind][maxWeight] = max(take, untake)
        
        return dp[ind][maxWeight]
    }
    
    return recursion(ind: weights.count-1, maxWeight: bagWeight)
}

//print(knapsack(weights: [3,2,5], values: [40,30,60], bagWeight: 5))

// MARK: Pseudo code > Tabulization + Space Optimization
// Approach: Bottom to Top // reverse the logic of Rec+Memo
// Tabulization
// Set the base dp (If we had only one element, for that we have to set the maxValues from weight 0 to maxWeight)
// Set all values of dp to 0
// In dp, from weights[0] to maxWeight, we set value as values[0]

// Iterate for each ind and target in ascending order other than 0
// inside ind iteration
// Iterate for each weight in descending order till 0
// untake, take same logic
// set dp[weight] = max(untake, take)
// outside weight loop
// outside ind loop
// return dp[maxWeight]

func knapsackTab(weights: [Int], values: [Int], bagWeight: Int) -> Int {
    
    var dp = Array(repeating: 0, count: bagWeight+1)
    
    for weight in weights[0]...bagWeight {
        dp[weight] = values[0]
    }
    
    for ind in 1..<weights.count {
        for maxWeight in stride(from: bagWeight, to: 0, by: -1) {
            var take = 0
            if maxWeight >= weights[ind] {
                take = values[ind] + dp[maxWeight - weights[ind]]
            }
            dp[maxWeight] = max(take, dp[maxWeight])
        }
    }
    
    return dp[bagWeight]
}

print(knapsackTab(weights: [3,2,5], values: [40,30,60], bagWeight: 5))
