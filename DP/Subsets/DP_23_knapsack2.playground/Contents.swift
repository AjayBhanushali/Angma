// DP_23: https://www.youtube.com/watch?v=OgvOZ6OrJoY&list=PLgUwDviBIf0qUlt5H_kiKYaNSqJ81PMMY&index=24
// https://bit.ly/3IvPdXS

// MARK: Pseudo code > Recursion + Memoization
// Approach: Top to Bottom untake take
// base case
// if ind == 0
// if bagCapacity >= profit at 0
// return profit * bagCapacity/profit
// else return 0

// recursive case
// untake ind-1, bagCapacity
// take = 0
// if bagCapacity >= weights at ind
// take = profit at ind + recursion(ind, bagCapacity-weights at ind)
// return max(take, untake)

func unboundedKnapsack(weights: [Int], profits: [Int], bagCapacity: Int) -> Int {
    var memo = Array(repeating: Array(repeating: -1, count: bagCapacity+1), count: weights.count)
    
    func recursion(ind: Int, bagCapacity: Int) -> Int {
        
        if ind == 0 {
            if bagCapacity >= weights[ind] {
                return profits[ind] * (bagCapacity/weights[ind])
            } else {
                return 0
            }
        }
        
        if memo[ind][bagCapacity] != -1 {
            return memo[ind][bagCapacity]
        }
        
        let untake = recursion(ind: ind-1, bagCapacity: bagCapacity)
        
        var take = 0
        
        if bagCapacity >= weights[ind] {
            take = profits[ind] + recursion(ind: ind, bagCapacity: bagCapacity-weights[ind])
        }
        
        memo[ind][bagCapacity] = max(take, untake)
        
        return max(take, untake)
    }
    
    return recursion(ind: weights.count-1, bagCapacity: bagCapacity)
}

print(unboundedKnapsack(weights: [2,4,6], profits: [5,11,13], bagCapacity: 10))

// MARK: Pseudo code > Recursion + Memoization
// Approach: Bottom to Top + single array
// Base case
// create maxProfits with profits inside it as 0
// fill the weights array till bagWeight for item at first index
// Iteration
// For of ind acending
// for of bagWeight descending
// untake the maxProfits[ind]
// in take check for weight capacity
// take current weight as many times we can + take maxProfits for remaining weight
// store in maxProfts at weight
// return last item of maxProfits

func unboundedKnapsackTab(weights: [Int], profits: [Int], bagCapacity: Int) -> Int {
    var maxProfits = Array(repeating: 0, count: bagCapacity+1)
    
    for bagCapacity in 0...bagCapacity {
        if bagCapacity >= weights[0] {
            maxProfits[bagCapacity] = profits[0] * bagCapacity/weights[0]
        }
    }
    
    for ind in 1..<weights.count {
        for bagCapacity in 0...bagCapacity {
            let untake = maxProfits[bagCapacity]
            var take = 0
            if bagCapacity >= weights[ind] {
                take = profits[ind] + maxProfits[bagCapacity - weights[ind]]
            }
            
            maxProfits[bagCapacity] = max(take, untake)
        }
    }
    
    return maxProfits[bagCapacity]
}

print(unboundedKnapsackTab(weights: [2,4,6], profits: [5,11,13], bagCapacity: 10))


