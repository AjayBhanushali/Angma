
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

//buySell([[8,7,1,5,3,6,4,100,200,5,6,2,88,4,6]])

func multiBuySell(_ list: [Int]) -> Int {
    
    func recursion(_ ind: Int) -> Int {
        
        if ind == 0 {
            return 0
        }
        
        let currentPrice = list[ind]
        let lastPrice = list[ind-1]
        
        var profit = 0
        
        if currentPrice > lastPrice {
            profit = currentPrice - lastPrice
        }
        print(ind, profit)
        return profit + recursion(ind-1)
    }
    
    return recursion(list.count-1)
}

//multiBuySell([7,1,5,3,6,4,8])
//multiBuySell([3,6,4,8])
//multiBuySell([1,5,3,4,9])

// 37

func maxTwoTransacation(_ list: [Int]) -> Int {
    func recursion(_ ind: Int) -> (Int, Int) {
        if ind == 0 {
            return (0, 0)
        }
        
        let currentPrice = list[ind]
        let lastPrice = list[ind-1]
        
        let previousProfits = recursion(ind-1)
        var maxProfits = previousProfits
        if currentPrice > lastPrice {
            let currentProfit = currentPrice - lastPrice
            
            if currentProfit > previousProfits.0 {
                maxProfits.1 = maxProfits.0
                maxProfits.0 = currentProfit
                return maxProfits
            }
             
            if currentProfit > previousProfits.1 {
                maxProfits.1 = currentProfit
                return maxProfits
            }
            
        } else {
            return previousProfits
        }
        
        return previousProfits
    }
    
    let profits = recursion(list.count-1)
    return profits.0 + profits.1
}

//print(maxTwoTransacation([1,2,3,4,5]))


func maxBuy(prices: [Int], t: Int) -> Int {
    
    var memo = Array(repeating: Array(repeating: -1, count: t+1), count: prices.count)
    
    func recursion(i: Int, t: Int) -> Int {
        if t == 0 { return 0 }
        if i < 0 { return 0 }
        
//        if memo[i][t] != -1 {
//            return memo[i][t]
//        }
        
        var maxProfit = 0
        
        for bI in stride(from: i-1, through: 0, by: -1) {
            if prices[i] > prices[bI] {
                print(prices[i], prices[bI])
                let currentProfit = (prices[i]-prices[bI]) + recursion(i: bI-1, t: t-1)
                maxProfit = max(maxProfit, currentProfit)
            } 
        }
//        memo[i][t] = maxProfit
        return maxProfit
    }
    
    var maxProfit = 0
    
    for i in stride(from: prices.count-1, to: 0, by: -1) {
        print(i)
        maxProfit = max(recursion(i: i, t: t), maxProfit)
    }
    
    return maxProfit
}

//maxBuy(list: [7,1,5,3,6,4,8], t: 2)
maxBuy(prices: [3,2,6,5,0,3], t: 2)
