
func permutation(list: [Int]) {
    print(recursion(array: list))
    func recursion(array: [Int]) -> [[Int]] {
        var array = array
        if array.count == 2 {
            return [array, [array[1], array[0]]]
        }
        var yolo: [[Int]] = []
        for _ in 0..<array.count {
            let firstItem = array[0]
            var newArray = array
            newArray.removeFirst()
            let attachments = recursion(array: newArray)
            
            for attachment in attachments {
                yolo.append([firstItem] + attachment)
            }
           array = newArray + [firstItem]
        }
        return yolo
    }
}

permutation(list: [1,2,3])
print("=============")

func permutation2(array: [Int]) -> [[Int]] {
    var output: [[Int]] = []
    
    func recursion(p: Int, list: [Int]) {
        
        if p == list.count {
            output.append(list)
            return
        }
        
        var swapList = list
        
        for tp in p..<list.count {
            swapList.swapAt(p, tp)
            print("f(\(p+1), \(swapList)")
            recursion(p: p+1, list: swapList)
        }
    }
    print("f(0, \(array)")
    recursion(p: 0, list: array)
    return output
}

print(permutation2(array: [1,2,3]))
