import Foundation

// Find the best(max/min) solution with a constraint from a list
// Greedy

func knapsack(objects: [[Double]], maxWeight: Double) -> Double {
    let sortedObjects = objects.sorted(by: {$0[0]/$0[1] > $1[0]/$1[1]}) //nlogn
    var profit = 0.0
    var remainingWeight = maxWeight
    
    for object in sortedObjects { // O(n)
        if remainingWeight >= object[1] {
            profit += object[0]
            remainingWeight -= object[1]
        } else {
            let fraction = remainingWeight/object[1]
            profit += object[0] * fraction
            break
        }
    }
    return profit
}

knapsack(objects: [[10, 2], [5, 3], [15, 5], [7, 7], [6,1], [18, 4], [3, 1]], maxWeight: 15)


func activitySelection(activities: [[Int]]) -> Int {
    
    let sortedActivies = activities.sorted(by: {$0[1] < $1[1]})
    
    var noOfActivies = 0
    var currentTime = 0
    
    for activy in sortedActivies {
        if currentTime <= activy[0] {
            print(activy)
            currentTime = activy[1]
            noOfActivies += 1
        }
    }
    
    return noOfActivies
}

//activitySelection(activities: [[12, 25], [10, 20], [3, 10],[20, 30]])
//activitySelection(activities: [[0,6], [3,4], [1,2], [5,9], [5,7], [8,9]])

// MARK: Array
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var dict: [Int: Int] = [:]
    
    for i in 0..<nums.count {
        let lookingFor = target - nums[i]
        
        if let j = dict[lookingFor] {
            return [j, i]
        }
        dict[nums[i]] = i
    }
    
    return []
}

//print(twoSum([3,5,2,1], 6))

func buySellMaxProfit(_ prices: [Int]) -> Int {
    var l = 0
    var r = 1
    
    var profit = 0
    
    while r < prices.count {
        // Is it profitable?
        if prices[l] < prices[r] {
            profit = max(profit, prices[r] - prices[l])
        } else {
            // Means price on R is less than price on L, so lets buy on this day
            l = r
        }
        r+=1
    }
    
    return profit
}

buySellMaxProfit([2,4,1])

func containsDuplicate(_ nums: [Int]) -> Bool {
    var uNums = Set<Int>()
    
    for num in nums {
        if uNums.contains(num) {
            return true
        }
        uNums.insert(num)
    }
    
    return false
}

//containsDuplicate([1,2,3,1])

func containsDuplicate2(_ nums: [Int], _ k: Int) -> Bool {
    var i = 0
    var j = 0
    
    while j < nums.count {
        if j < k {
            j+=1
        } else if (j-i == k) {
            // Check for first and last
            print("K")
            if nums[i] == nums[j] {
                return true
            }
            i+=1
            j+=1
        }
    }
    
    return false
}

containsDuplicate2([1,2,3,6,5], 3)
var k=0

var memo = Array(repeating: -1, count: 5)

func noOfJumps(s: Int) -> Int {
    
//    if memo[s] != -1 {
//        return memo[s]
//    }
    
    if s == 0 { return 1 }
    
    var l = 0
    var r = 0
    
    if s - 1 >= 0 {
        k+=1
        l = noOfJumps(s: s-1)
    }
    
    if s - 2 >= 0 {
        k+=1
        r = noOfJumps(s: s-2)
    }
//    memo[s] = l + r
    return l + r
}
//
//noOfJumps(s: 4)
//print(k)

func reverseList(list: [Int]) -> [Int] {
    var list = list
    if list.isEmpty {
        return []
    }
    let last = list.removeFirst()
    return reverseList(list: list) + [last]
}

print(reverseList(list: [1,2,3]))

