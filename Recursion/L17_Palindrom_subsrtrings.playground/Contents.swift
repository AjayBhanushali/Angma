
// L14: https://www.youtube.com/watch?v=WBgsABoClE0&list=PLgUwDviBIf0rGlzIn_7rsaR2FQ5e6ZOL9&index=17

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

// MARK: Pseudo Code Recursion
// pick all the substrings
// while picking check if it is a palindrome
// If it is then check for the rest of the string
// Else add the next char in the current substring and recheck

func isPalindrome(_ str: String) -> Bool {
    var l = 0
    var r = str.count-1
    
    while l < r {
        if str[l] != str[r] {
            return false
        }
        
        l+=1
        r-=1
    }
    
    return true
}

func palindromePartioning(str: String) -> [[String]] {
    var result: [[String]] = []
    
    var path: [String] = []
    
    func recursion(divider: Int) {
        if divider == str.count {
            result.append(path)
            return
        }
        
        for i in divider..<str.count {
            if isPalindrome(str[divider ..< i+1]) {
                path.append(str[divider ..< i+1])
                recursion(divider: i+1)
                path.removeLast()
            }
        }
    }
    
    recursion(divider: 0)
    return result
}

print(palindromePartioning(str: "bbabbbba"))

