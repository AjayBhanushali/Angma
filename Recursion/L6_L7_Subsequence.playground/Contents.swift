// When question asks to find all
// Base case will always append the result
//
// When question asks for only one
// Base case will either return true or false
//
// When question asks for number of all
// Base case should return 1 or 0
// At the end return sum of recursions

//func fibbo(n: Int) -> Int {
//    if n == 0 {
//        return 0
//    }
//    if n == 1 {
//        return 1
//    }
//    
//    return fibbo(n: n-1) + fibbo(n: n-2)
//}
//
//print(fibbo(n: 2))
//L6: https://www.youtube.com/watch?v=AxNNVECce8c&list=PLgUwDviBIf0rGlzIn_7rsaR2FQ5e6ZOL9&index=6

//MARK: Print all subsequences

// 1. hold one value
// 2. Pick second value in the output
// 3. call recursion for that output with "increased index"
// 4. In recursion, if index == n then add and return
// 5. Once 3. recursion will be over, Unpick 2. value and call recursion with increased Index

// Time Complexity: (2^n)*n
// Space Complexity: O(n)

func l6(array: [Int]) {
    var result: [[Int]] = []
    
    recursion(i: 0, output: [])
    
    print(result)
    
    func recursion(i: Int, output: [Int]) {
        if i == array.count {
            result.append(output)
            return
        }
        
        // pick
        recursion(i: i+1, output: output + [array[i]])
        // unpick
        recursion(i: i+1, output: output)
    }
}

//l6(array: [2,1,3])

//L7: https://www.youtube.com/watch?v=eQCS_v3bw0Q&list=PLgUwDviBIf0rGlzIn_7rsaR2FQ5e6ZOL9&index=7

//MARK: Print all subsequences whose sum is K

// 1. Call recursion with f(output: [], i: 0, K: K)
// 2. Check if K < 0, If true return
// 3. Check if K == 0, If true, add n return
// 4. pick i'th value in output and call recursion for f(output, i+1, K-i'th value)
// 5. unpick i'th value in output and call recursion for f(output, i+1, K-i'th value)

// Time Complexity: (2^n)*n
// Space Complexity: O(n)

func l7_1(array: [Int], k: Int) {
    var result: [[Int]] = []
    recursion(i: 0, k: k, output: [])
    print(result)
    func recursion(i: Int, k: Int, output: [Int]) {
        if k == 0 {
            result.append(output)
            return
        }
        
        if k < 0 || i == array.count {
            return
        }
        
        recursion(i: i+1, k: k-array[i], output: output + [array[i]])
        recursion(i: i+1, k: k, output: output)
    }
}

//l7_1(array: [1,2,1], k: 2)

//MARK: Print First subsequences whose sum is K

// 1. Call recursion with f(output: [], i: 0, K: K)
// 2. Check if K < 0, If true return false
// 3. Check if K == 0, If true, add n return true
// 4. Pick i'th value in the output and call recursion for f(output, i+1, K-i'th value)
// 5. If above recursion returns true then return true else
// 6. Unpick i'th value from the output and call recursion for f(output, i+1, K)
// 7. If above recursion returns true then return true else return false

// Time Complexity: (2^n)*n
// Space Complexity: O(n)

func l7_2(array: [Int], k: Int) {
    var result: [Int] = []
    recursion(i: 0, k: k, output: [])
    print(result)
    func recursion(i: Int, k: Int, output: [Int]) -> Bool {
        if k == 0 {
            result = output
            return true
        }
        
        if k < 0 || i == array.count {
            return false
        }
        
        if recursion(i: i+1, k: k-array[i], output: output + [array[i]]) {
            return true
        }
        
        if recursion(i: i+1, k: k, output: output) {
            return true
        }
        
        return false
    }
}

//l7_2(array: [1,2,1], k: 2)

//MARK: Count subsequences whose sum is K

// 1. Call recursion with f(i: 0, k: k, output: [])
// 2. If K < 0, return 0
// 3. If k == 0 return 1
// 4. Pick i'th in the output and call recursion for f(i+1, k-i'th, output)
// 5. Unpick i'th from the output and call recursion for f(i+1, k, output)
// 6. return 4 + 5

// Time Complexity: (2^n)*n
// Space Complexity: O(n)

func l7_3(array: [Int], k: Int) -> Int {
    func recursion(i: Int, k: Int, output: [Int]) -> Int {
        if k == 0 {
            return 1
        }
        
        if k < 0 || i == array.count {
            return 0
        }
        
        let l = recursion(i: i+1, k: k-array[i], output: output + [array[i]])
        let r = recursion(i: i+1, k: k, output: output)
        return (l + r)
    }
    return recursion(i: 0, k: k, output: [])
}

print(l7_3(array: [1,2,1], k: 2))


