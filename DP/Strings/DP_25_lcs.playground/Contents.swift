extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

// DP_25: https://www.youtube.com/watch?v=NPZn9jBrX8U&list=PLgUwDviBIf0qUlt5H_kiKYaNSqJ81PMMY&index=26
// Problem Link: https://bit.ly/3pvkqUd

// MARK: Recursion + Memo
// Approach:
// Top to bottom
// We will focus on one char at time. We will check if char1 is availble in string2 and char2 in string2

// MARK: Pseudo code
// We will call recursion for the indexes, which will return the maxLength.
// Call recusion(i: lastIndex1, j: lastIndex2)

// Inside recursion
// Base case
// if i, j < 0, return 0

// Memo check

// Recursive case
// If char1 == char2, return 1 + recursion for -1 indexes
// else return max of recursions for i-1,j and i,j-1

func lcs(s1: String, s2: String) -> Int {
    
    var memo = Array(repeating: Array(repeating: -1, count: s1.count), count: s1.count)
    
    func recursion(i: Int, j: Int) -> Int {
        
        // Base case
        if i < 0 || j < 0 {
            return 0
        }
        
        // Memo check
        if memo[i][j] != -1 {
            return memo[i][j]
        }
        
        // recursive case
        if s1[i] == s2[j] {
            memo[i][j] = 1 + recursion(i: i-1, j: j-1)
            return memo[i][j]
        } else {
            memo[i][j] = max(recursion(i: i, j: j-1), recursion(i: i-1, j: j))
            return memo[i][j]
        }
    }
    
    return recursion(i: s1.count-1, j: s1.count-1)
}

lcs(s1: "acd", s2: "ced")

// MARK: Tabulation + Space optimization
// Approach
// Bottom to Top
// Set previous: ans for i=0 and j 0 to count-1
// Iterations
// for i in 1 to count-1
// for j in 0 to count-1
// if char at i and j same, then set current[j] = 1 + prev[j-1]
// else current[j] = max(prev[j], current[j-1])

// return last of previous

func lcsTab(s1: String, s2: String) -> Int {
    var previous = Array(repeating: 0, count: s1.count)
    
    for j in 0..<s1.count {
        if s1[0] == s2[j] {
            previous[j] = 1
        }
    }
    
    for i in 1..<s1.count {
        var current = Array(repeating: 0, count: s1.count)
        
        for j in 0..<s2.count {
            if s1[i] == s2[j] {
                current[j] = 1
                if j-1 >= 0 {
                    current[j] += previous[j-1]
                }
            } else {
                current[j] = previous[j]
                if j-1 >= 0 {
                    current[j] = max(previous[j], current[j-1])
                }
            }
        }
        
        previous = current
    }
    
    return previous[s1.count-1]
}

lcsTab(s1: "acd", s2: "ced")
lcsTab(s1: "ced", s2: "acd")
