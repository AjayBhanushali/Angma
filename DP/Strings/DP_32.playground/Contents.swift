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

// DP_25: https://www.youtube.com/watch?v=nVG7eTiD2bY&list=PLgUwDviBIf0qUlt5H_kiKYaNSqJ81PMMY&index=33

// Look for each char of s2 in s1
// If found look for next char of s2 in s1
// Once found all return 1


func distinctSubsequence(s1: String, s2: String) -> Int {
    
    var memo = Array(repeating: Array(repeating: -1, count: s2.count), count: s1.count)
    
    func recursion(l: Int, r: Int) -> Int {
        if r == s2.count {
            return 1
        }
        
        if memo[l][r] != -1 {
            return memo[l][r]
        }
        
        var match = 0
        
        for i in l..<s1.count {
            if s1[i] == s2[r] {
                match += recursion(l: i+1, r: r+1)
            }
        }
        memo[l][r] = match
        return match
    }
    
    let match = recursion(l: 0, r: 0)
    
    for m in memo {
        print(m)
    }
    
    return match
}

// MARK: Tabulization

distinctSubsequence(s1: "babgbag", s2: "bag")
