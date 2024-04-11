import Foundation

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
        print(i,j)
        sum -= array[i]
        sum += array[j]
        maxi = max(maxi, sum)
        i += 1
        j += 1
    }

    return maxi
}

findMaxInSubArray(array: [2,3,4,5,6,7,8], k: 3)

//// https://www.geeksforgeeks.org/problems/first-negative-integer-in-every-window-of-size-k3345/1

//func firstNegativeInteger(arr: [Int], k: Int, n: Int) -> [Int] {
//    var result: [Int] = []
//    var negatives: [Int] = []
//
//    var i = 0
//    var j = 0
//
//    while j < n {
//        if arr[j] < 0 {
//            negatives.append(arr[j])
//        }
//
//        if (j - i + 1) == k {
//            if let negative = negatives.first {
//                result.append(negative)
//
//                if arr[i] == negative {
//                    negatives.removeFirst()
//                }
//            } else {
//                result.append(0)
//            }
//
//            i+=1
//            j+=1
//        } else {
//            j+=1
//        }
//    }
//
//    return result
//}
//
//print(firstNegativeInteger(arr: [12,-1,-7,8,-15,30,16,28], k: 3, n: 8))

// https://www.geeksforgeeks.org/problems/count-occurences-of-anagrams5839/1

//extension String {
//    func charAt(_ i: Int) -> Character {
//        return self[index(startIndex, offsetBy: i)]
//    }
//}

//func anagramOcuurences(txt: String, pat: String) -> Int {
//    var result = 0
//    var storage: [Character: Int] = [:]
//    
//    pat.forEach({storage[$0, default: 0] += 1})
//
//    var storageCounter = storage.count
//    var i = 0
//    var j = 0
//    var n = txt.count
//    var k = pat.count
//    
//    while j < n {
//        let jChar = txt.charAt(j)
//        // Calculation
//        if storage[jChar] != nil {
//            storage[jChar]! -= 1
//            
//            if storage[jChar] == 0 {
//                storageCounter -= 1
//                
//                if storageCounter == 0 {
//                    result += 1
//                }
//            }
//        }
//        
//        if (j-i+1) == k {
//            // i calculation
//            let iChar = txt.charAt(i)
//            if storage[iChar] != nil {
//                storage[iChar]! += 1
//                
//                if storage[iChar]! > 0 {
//                    storageCounter += 1
//                }
//            }
//            
//            // Slide Window
//            i+=1
//            j+=1
//        } else {
//            j+=1
//        }
//    }
//    return result
//}

//anagramOcuurences(txt: "aabaabaa", pat: "aaba")
//anagramOcuurences(txt: "forxxorxfxdofor", pat: "for")
//anagramOcuurences(txt: "fonrfor", pat: "for")
//(const int* A, int n1, int B, int *len1)

//func findMax(arr: [Int], k: Int = 3) -> [Int] {
//    var result: [Int] = []
//    var maxs: [Int] = []
//    var i = 0
//    var j = 0
//    let n = arr.count
//    
//    while j < n {
//        let jValue = arr[j]
//        
//        let x = 0
//        
//        while !maxs.isEmpty && maxs[maxs.count-1] < jValue {
//            maxs.removeLast()
//        }
//        maxs.append(jValue)
//        if (j-i+1) < k {
//            j+=1
//        } else {
//            result.append(maxs[0])
//            
//            if arr[i] == maxs[0] {
//                maxs.removeFirst()
//            }
//            
//            i+=1
//            j+=1
//        }
//    }
//    
//    return result
//}
//
//// 3,2,1
//// Result 7,7,3
//print(findMax(arr: [9,10,9,-7,-4,-8,2,-6], k: 5))
//print(findMax(arr: [6,7,3,2,1])) //55599
//print(findMax(arr: [1,2,8,9]))
//print(findMax(arr: [1,2,3,8,9]))
//print(findMax(arr: [1,3,-1,-3,5,3,6,7]))
//print(findMax(arr: [5,1,5,2,4,9,9])) //55599

//4 1 1 1 2 3 5
//func findLongestSum(arr: [Int], sum: Int) -> Int {
//    var longestSum = 0
//    var n = arr.count
//    var i = 0
//    var j = 0
//    
//    var total = 0
//    while j < n {
//        total = total + arr[j]
//        
//        if total < sum {
//            j+=1
//        } else if total == sum {
//            longestSum = max(longestSum, j-i+1)
//            j+=1
//        } else {
//            while total > sum {
//                total -= arr[i]
//                i+=1
//            }
//            j+=1
//        }
//    }
//    
//    return longestSum
//}
//
//print(findLongestSum(arr: [4,1,1,1,2,3,5], sum: 5))
//extension String {
//    func at(_ i: Int) -> Character {
//        return self[index(startIndex, offsetBy: i)]
//    }
//}
//func uniqueChars(text: String, k: Int) -> Int {
//    var l = 0
//    var n = text.count
//    var i = 0
//    var j = 0
//    var total = 0
//    var dict: [Character: Int] = [:]
//    
//    while j < n {
//        // Calculation
//        let jChar = text.at(j)
//        
//        if dict[jChar] == nil {
//            total += 1
//            dict[jChar] = 1
//        } else {
//            dict[jChar, default: 0] += 1
//        }
//        // End Calculation
//        
//        if total < k {
//            j+=1
//        } else if total == k {
//            // Ans Calculation
//            l = max(l, j-i+1)
//            // End Ans Calculation
//            j+=1
//        } else if total > k {
//            while total > k {
//                let iChar = text.at(i)
//                dict[iChar, default: 1] -= 1
//                if dict[iChar] == 0 {
//                    total -= 1
//                    dict.removeValue(forKey: iChar)
//                }
//                i+=1
//            }
//            j+=1
//        }
//    }
//    return l
//}
//
//print(uniqueChars(text: "aabacbebebe", k: 3))
//print(uniqueChars(text: "aabacbebe", k: 3))
//print(uniqueChars(text: "abaccab", k: 2))

//extension String {
//    func at(_ i: Int) -> Character {
//        return self[index(startIndex, offsetBy: i)]
//    }
//}
//abcabcbb
//func uniqueNonRepeatingChars(text: String) -> Int {
//    var l = 0
//    var n = text.count
//    var i = 0
//    var j = 0
//    var sets = Set<Character>()
//    
//    while j < n {
//        let jChar = text.at(j)
//        if !sets.contains(jChar) {
//            sets.insert(jChar)
//            l = max(l, j-i+1)
//            j+=1
//        } else {
//            while sets.contains(jChar) {
//                let iChar = text.at(i)
//                sets.remove(iChar)
//                i+=1
//            }
//            sets.insert(jChar)
//            j+=1
//        }
//    }
//    
//    return l
//}

//func uniqueNonRepeatingChars(text: String) -> Int {
//    var l = 0
//    var n = text.count
//    var i = 0
//    var j = 0
//    var dict: [Character: Int] = [:]
//    
//    while j < n {
//        let jChar = text.at(j)
//        dict[jChar, default: 0] += 1
//        
//        if dict.count == (j-i+1) {
//            l = max(l, j-i+1)
//            j+=1
//        } else if dict.count < (j-i+1) {
//            while dict.count < (j-i+1) {
//                let iChar = text.at(i)
//                dict[iChar, default: 1] -= 1
//                
//                if dict[iChar] == 0 {
//                    dict.removeValue(forKey: iChar)
//                }
//                i+=1
//            }
//            j+=1
//        }
//    }
//    
//    return l
//}
//
//uniqueNonRepeatingChars(text: "abcabcbb")
//uniqueNonRepeatingChars(text: "abcadcbb")
//uniqueNonRepeatingChars(text: "abc")
//uniqueNonRepeatingChars(text: " ")

func findsubString(s: String, t: String) -> String {
    var i = 0, j = 0
    var n = s.count
    var dict: [Character: Int] = [:]
    
    for c in t {
        dict[c, default: 0] += 1
    }
    
    var counter = dict.count
    
    var shortest = n
    var sI: Int?
    var sJ: Int?
    
    while j < n {
        // Calculation
        let jC = s[s.index(s.startIndex, offsetBy: j)]
        
        if dict[jC] != nil {
            dict[jC, default: 0] -= 1
            
            if dict[jC] == 0 {
                counter -= 1
            }
        }
        
        if counter > 0 {
            j+=1
        } else if counter == 0 {
            while counter == 0 {
                // Ans Calcualation
                if (j-i+1) <= shortest {
                    sI = i
                    sJ = j
                    shortest = j-i+1
                }
                
                // Remove I
                let iC = s[s.index(s.startIndex, offsetBy: i)]
                
                if dict[iC] != nil {
                    dict[iC, default: 0] += 1
                    
                    if dict[iC]! > 0 {
                        counter += 1
                    }
                }
                i+=1
            }
            j+=1
        }
    }
    
    guard let sI, let sJ else { return "" }
    
    let startIndex = s.index(s.startIndex, offsetBy: sI)
    let endIndex = s.index(s.startIndex, offsetBy: sJ)
    print(sI, sJ)
    return String(s[startIndex...endIndex])
}
//
//findsubString(s: "adobecodebanc", t: "abc")
//findsubString(s: "adobacodebanc", t: "abcc")
//findsubString(s: "a", t: "aa")
