import Foundation
print("rr")
func findMaxInSubArray(array: [Int], k: Int) -> Int {
    var i = 0
    var j = 0
    var max = 0
    var sum = 0
    
    while j < k {
        sum += array[j]
        j++
    }
    
    max = sum
    
    while j < array.count {
        sum -= array[i]
        i += 1
        j += 1
        sum += array[j]
        
        max = max(max, sum)
    }
    
    return max
}

int i = 0;
        int j = 0;

    int max = 0;
    int sum = 0;

    while (j < K) {
        sum += Arr.get(j);
        j++;
    }

    max = sum;

    while (j < N) {
        sum = sum - Arr.get(i);
        sum = sum + Arr.get(j);
        i++;
        j++;
        max = Math.max(max, sum);
    }

    return max;


