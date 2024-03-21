import Foundation
print("rr")
func findMaxInSubArray(array: [Int], k: Int) -> Int {
    var i = 0
    var j = 0
    var maxi: Int = 0
    var sum: Int = 0
    
    while j < k {
        sum += array[j]
        j+=1
    }
    
    maxi = sum
    
    while j < array.count {
        sum -= array[i]
        i += 1
        j += 1
        sum += array[j]
        
        maxi = max(maxi, sum)
    }
    
    return maxi
}
findMaxInSubArray(array: [2,3,4,5,6,7,8], k: 3)

