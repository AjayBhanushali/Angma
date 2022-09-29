
func buySell(_ list: [Int]) -> Int {
    var buy = list[0]
    var sell = 0
    
    for i in 1..<list.count {
        if list[i] < buy {
            buy = list[i]
        } else if list[i] > buy && list[i] > sell {
            sell = list[i]
        }
    }
    
    return sell-buy
}

buySell([8,7,1,5,3,6,4,100,200,5,6,2,88,4,6])

func multiBuySell(_ list: [Int]) -> Int {
    
    func recursion(_ list: [Int]) -> Int {
        
        if list.count == 1 {
            return 0
        }
        
        let currentPrice = list[list.count-1]
        let lastPrice = list[list.count-2]
        
        var profit = 0
        
        if currentPrice > lastPrice {
            profit = currentPrice - lastPrice
        }
        
        var removedList = list
        removedList.removeLast()
        
        return profit + recursion(removedList)
    }
    
    return recursion(list)
}

multiBuySell([7,1,5,3,6,10])

