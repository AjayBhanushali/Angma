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

func editDistance(s1: String, s2: String) -> Int {
    
    func recursion(i1: Int, s3: String, i2: Int) -> Int {
        print("=========")
        print("f> \(s3) , i1: \(i1) , i2: \(i2)")
        
        if i2 == s2.count {
            print("return> \(abs(s3.count-s2.count))")
            return abs(s3.count-s2.count)
        }
        
        if s3.count < s2.count {
            return s2.count-s3.count
        }
        
        if s3 == s2 {
            return 0
        }
        
        if s3[i1] == s2[i2] {
            return recursion(i1: i1+1, s3: s3, i2: i2+1)
        }
        
        let char = s2[i2]
        print(char)
        
        // Replace
        var replacedS3 = s3
        replacedS3.remove(at: replacedS3.index(replacedS3.startIndex, offsetBy: i1))
        replacedS3.insert(char.first!, at: replacedS3.index(replacedS3.startIndex, offsetBy: i1))
        print("Replaced \(s3): \(replacedS3)")
        let replaced = recursion(i1: i1+1, s3: replacedS3, i2: i2+1)
        
        // Insert
        var insertedS3 = s3
        insertedS3.insert(char.first!, at: insertedS3.index(insertedS3.startIndex, offsetBy: i1))
        print("Inserted \(s3): \(insertedS3)")
        let inserted = recursion(i1: i1+1, s3: insertedS3, i2: i2+1)
        
        // Delete
        var deletedS3 = s3
        deletedS3.remove(at: deletedS3.index(deletedS3.startIndex, offsetBy: i1))
        print("Deleted \(s3): \(deletedS3)")
        let deleted = recursion(i1: i1, s3: deletedS3, i2: i2)
        
        return min(replaced, inserted, deleted) + 1
    }
    
    return recursion(i1: 0, s3: s1, i2: 0)
}

print("Result \(editDistance(s1: "hor", s2: "ro"))")


