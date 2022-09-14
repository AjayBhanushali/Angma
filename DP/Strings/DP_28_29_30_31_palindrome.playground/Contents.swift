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
    
    return previous[s2.count-1]
}

let str = "bbabcbcab"
let rstr = String(str.reversed())
// 28
print(lcsTab(s1: str, s2: rstr))

// 29
print(str.count-lcsTab(s1: str, s2: rstr))

// 29
let left = "abcd"
let right = "anc"
let lcss = lcsTab(s1: left, s2: right)
print((left.count-lcss)+(right.count-lcss))

// 31

func lcSuperSequenceTab(s1: String, s2: String) -> String {
//    var previous = Array(repeating: 0, count: s1.count)
    var dp = Array(repeating: Array(repeating: 0, count: s2.count+1), count: s1.count+1)
    
    for j in 0..<s1.count {
        if s1[0] == s2[j] {
            dp[0][j] = 1
        }
    }
    
    for i in 1...s1.count {
        
        for j in 1...s2.count {
            if s1[i] == s2[j] {
                dp[i][j] = 1
                if j-1 >= 0 {
                    dp[i][j] += dp[i-1][j-1]
                }
            } else {
                dp[i][j] = dp[i-1][j]
                if j-1 >= 0 {
                    dp[i][j] = max(dp[i-1][j], dp[i][j-1])
                }
            }
        }
    }
    print(dp)
    var i = s1.count
    var j = s2.count
    var str = ""
    
    while i > 0 && j > 0 {
        print("sdf")
        print(i,j)
        if s1[i-1] == s2[j-1] {
            str = s1[i-1] + str
            i -= 1
            j -= 1
        } else if dp[i-1][j] > dp[i][j-1] {
            str = s1[i-1] + str
            i -= 1
        } else {
            str = s2[j-1] + str
            j -= 1
        }
    }
    
    while i > 0 {
        str = s1[i-1] + str
        i-=1
    }
    
    while j > 0 {
        str = s2[j-1] + str
        j-=1
    }
    
    return str
}

print(lcSuperSequenceTab(s1: "brute", s2: "groot"))
