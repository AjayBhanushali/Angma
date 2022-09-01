//L8: https://www.youtube.com/watch?v=OyZFFqQtu98&list=PLgUwDviBIf0rGlzIn_7rsaR2FQ5e6ZOL9&index=8

//MARK: Combination Sum > a number can be repeated unlimited of times

// 1. Call the recursion for f(i: 0, k: k, output: []) Then in recursion
// 2. if k == 0, add output to the result and return
// 3. if k < 0 or k == n, return
// 4. Add i'th in output and call recursion for f(i, k: k-i'th, output + i'th)
// 5. Add i+1'th in output and call recursion for f(i+1, k: k-i+1'th, output + i+1'th)

// Time Complexity: (2^n)*n
// Space Complexity: O(n)

func l8(array: [Int], k: Int) {
    var result: [[Int]] = []
    recursion(i: 0, k: k, output: [])
    print(result)
    func recursion(i: Int, k: Int, output: [Int]) {
        print("1")
        if k == 0 {
            result.append(output)
            return
        }
        
        
        if k < 0 || i == array.count {
            return
        }
        
        for j in i..<array.count {
            recursion(i: j, k: k-array[j], output: output + [array[j]])
        }
    }
}

//l8(array: [2,3,6,7], k: 7)

//MARK: Combination Sum 2 > Print all whose sum is K, Cannot repeat same element, output must be unique
// 1,1,1,2,2 | k 4 > 1,1,2 | 2,2
// Call the recursion f(i: 0, k: k, output: [])
// if k == 0, append output in result and return
// Loop from i to n-1
// in horizontal progression if output is equal last output then "continue(j++)"
// If j'th > k return, as it surpass the sum
// Pick j'th in the output, call recursion for f(j+1, k-j'th, output+j'th)

// Time Complexity: (2^n)*n
// Space Complexity: O(n)

func l9(array: [Int], k: Int) {
    var result: [[Int]] = []
    let array = array.sorted()
    recursion(i: 0, k: k, output: [])
    print(result)
    func recursion(i: Int, k: Int, output: [Int]) {
        
        print(i,k,output)
        
        if k == 0 {
            print("added")
            result.append(output)
            return
        }
        
        // Horizontal Progression
        for j in i..<array.count {
            // if output will be equal to last output
            if i != j && array[j-1] == array[j] {
                continue
            }
            
            if array[j] > k {
                return
            }
            
            recursion(i: j+1, k: k-array[j], output: output + [array[j]])
        }
    }
}

l9(array: [10,1,2,7,6,1,5], k: 8)



