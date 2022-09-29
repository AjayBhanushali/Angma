import Foundation
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

//https://www.youtube.com/watch?v=ZmlQ3vgAOMo
//https://bit.ly/3qXtORt

func wildcardMatching(s1: String, s2: String) -> Bool {
    var memo = Array(repeating: Array(repeating: -1, count: s2.count), count: s1.count)
    
    func recursion(i: Int, j: Int) -> Bool {
        print(i,j)
        if i < 0 && j >= 0 {
            return false
        }
        
        if j < 0 && i < 0 {
            return true
        }
        
        if memo[i][j] != -1 {
            return memo[i][j] == 1
        }
        
        if s1[i] == s2[j] || s1[i] == "?" {
            return recursion(i: i-1, j: j-1)
        }
        
        if s1[i] == "*" && i > 0 {
            var x = j
            while s1[i-1] != s2[x] && x >= 0 {
                x-=1
                memo[i][x] = 1
            }
            memo[i][j] = recursion(i: i-1, j: x) ? 1 : 0
            return memo[i][j] == 1
        } else if s1[i] == "*" {
            memo[i][j] = 1
            return true
        }
        
        memo[i][j] = 0
        return false
    }
    
    return recursion(i: s1.count-1, j: s2.count-1)
}

print(wildcardMatching(s1: "ab*c", s2: "abdefcd"))

print(wildcardMatching(s1: "?ay", s2: "jay"))

print(wildcardMatching(s1: "ab*d", s2: "abcc"))

print(wildcardMatching(s1: "*abcd", s2: "abcd"))
