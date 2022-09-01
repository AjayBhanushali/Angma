// DP_20: https://www.youtube.com/watch?v=myPeWb3Y68A&list=PLgUwDviBIf0qUlt5H_kiKYaNSqJ81PMMY&index=21
// https://bit.ly/3HJTeIl

// MARK: Pseudo code > Recursion + Memoization
// Approach: Top to Bottom
// Call recursion for the last item in the grid
// Base case
// when we have reached the 0th item, see if we can return same coin(no of times) to get the target

// Recursive case
// untake the current item
// take the current item for as many times we can

func minimumElements(array: [Int], target: Int) -> Int {
    var memo = Array(repeating: Array(repeating: -1, count: target+1), count: array.count)
    
    func recursion(ind: Int, target: Int) -> Int {
        if ind == 0 {
            if target%array[0] == 0 {
                return target/array[0]
            } else {
                return 100
            }
        }
        
        if memo[ind][target] != -1 {
            return memo[ind][target]
        }
        
        let untake = recursion(ind: ind-1, target: target)
        
        var take = 100
        
        if target >= array[ind] {
            take = 1 + recursion(ind: ind, target: target-array[ind])
        }
        
        return min(untake, take)
    }
    
    return recursion(ind: array.count-1, target: target)
}

//print(minimumElements(array: [9,5,6,1], target: 11))
//print(minimumElements(array: [1,2,3], target: 8))

func minimumElementsTab(array: [Int], target: Int) -> Int {
    var previous = Array(repeating: 100, count: target+1)
    
    for target in 0...target {
        if target%array[0] == 0 {
            previous[target] = target/array[0]
        }
    }
    
    print(previous)
    for ind in 1..<array.count {
        var current = Array(repeating: 100, count: target+1)
        
        for target in 0...target {
            let untake = previous[target] // 4
            var take = 100
            if target >= array[ind] {
                take = 1 + current[target-array[ind]]
            }
            current[target] = min(untake, take)
        }
        previous = current
        print(previous)
    }
    
    return previous[target]
}

print(minimumElementsTab(array: [9,5,6,1], target: 11))
print(minimumElementsTab(array: [1,2,3], target: 8))
