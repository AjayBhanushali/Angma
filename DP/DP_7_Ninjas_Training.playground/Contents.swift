func ninja(tasks: [[Int]]) -> Int {
    
    var memo = Array(repeating: Array(repeating: -1, count: tasks[0].count), count: tasks.count)
    
    func rec(r: Int, lastC: Int) -> Int {
        var maxPoints = Int.min
        
        if r == -1 {
            return 0
        }
        
        if lastC != -1 {
            if memo[r][lastC] != -1 {
                return memo[r][lastC]
            }
        }
        
        for c in 0..<tasks[r].count {
            if lastC == c {
                continue
            }
            let points = tasks[r][c] + rec(r: r-1, lastC: c)
            maxPoints = max(maxPoints, points)
        }
        
        if lastC != -1 {
            memo[r][lastC] = maxPoints
        }
        
        return maxPoints
    }
    
    return rec(r: tasks.count-1, lastC: -1)
}

func ninjaTab(tasks: [[Int]]) -> Int {
    
    var lastMaxs: [Int] = Array(repeating: 0, count: tasks[tasks.count-1].count)
    
    for r in 0..<tasks.count {
        var currentMaxs: [Int] = []
        for c in 0..<tasks[r].count {
            
            var lastMax = 0
            
            for lastC in 0..<lastMaxs.count {
                if lastC == c {
                    continue
                }
                lastMax = max(lastMax, lastMaxs[lastC])
            }
            
            let max = tasks[r][c] + lastMax
            currentMaxs.append(max)
        }
        lastMaxs = currentMaxs
    }
    
    return lastMaxs.max() ?? 0
}

print(ninja(tasks: [[1,2,5], [3,1,1], [3,3,3]]))
print(ninja(tasks: [[1,2,5,9], [3,1,1,8], [3,6,3,3]]))
print(ninja(tasks: [[-1]]))

print(ninjaTab(tasks: [[1,2,5], [3,1,1], [3,3,3]]))
print(ninjaTab(tasks: [[1,2,5,9], [3,1,1,8], [3,6,3,3]]))
print(ninjaTab(tasks: [[-1]]))


//DP_7: https://www.youtube.com/watch?v=AE39gJYuRog&list=PLgUwDviBIf0qUlt5H_kiKYaNSqJ81PMMY&index=8

// MARK: Ninja's Training
// https://www.codingninjas.com/codestudio/problem-details/ninja-s-training_3621003

/*Ninja is planing this ‘N’ days-long training schedule. Each day, he can perform any one of these three activities. (Running, Fighting Practice or Learning New Moves). Each activity has some merit points on each day. As Ninja has to improve all his skills, he can’t do the same activity in two consecutive days. Can you help Ninja find out the maximum merit points Ninja can earn?
 
 You are given a 2D array of size N*3 ‘POINTS’ with the points corresponding to each day and activity. Your task is to calculate the maximum number of merit points that Ninja can earn.*/

// MARK: Pseudo code Memoization
// 1. Call the recursion from the last element f(row-1, lastTask)
// Last Task would be col count e.g. if col has 3 exercises then we will use 3 as no exercise done.
// So, first call would be f(row-1, col)
// 2. Inside, the recursion
// 3. Base case
// if we have reached day 0'th, then we just have to return the max point activity other than lastTask
// 4. Recursive case
// We will go through each activity for that day i.e. for of colums
// We will try to get the max for that day by adding col's activity point + recursion done on previous day(If not in memo)
// As we will call recursion for each col other than the lastTask, we need to get the max of all recursive's response and return that value.

//Time Complexity: O(r*c*(c+1))
//Space Complexity: O(r*(c+1))

struct yolo: Hashable {
    var day: Int
    var lastTask: Int
}

func ninjaTraining(tasks: [[Int]]) -> Int {
    
    var pointsTable: [Int : [Int]] = [:]
        
    func recursion(day: Int, lastTask: Int) -> Int {
        
        // If its in memo
        if pointsTable[day] != nil {
            let maxPoints = pointsTable[day]![lastTask]
            if maxPoints != 0 {
                return maxPoints
            }
        } else {
            pointsTable[day] = Array(repeating: 0, count: tasks[day].count)
        }
        
        let noOftasks = tasks[day].count
        
        // Base case
        if day == 0 {
            // If not in memo
            var maxPoints = 0
            
            for task in 0..<noOftasks {
                if task != lastTask {
                    maxPoints = max(maxPoints, tasks[day][task])
                }
            }
            
            pointsTable[day]![lastTask] = maxPoints
            return maxPoints
        }
        
        // recursive case
        var maxPoints = 0
        
        for task in 0..<noOftasks {
            if task != lastTask {
                let points = tasks[day][task] + recursion(day: day-1, lastTask: task)
                maxPoints = max(maxPoints, points)
            }
        }
        
        if lastTask != tasks.last!.count {
            pointsTable[day]![lastTask] = maxPoints
        }
        
        return maxPoints
    }
    
    return recursion(day: tasks.count-1, lastTask: tasks.last!.count)
}

//ninjaTraining(tasks: [[2,1,3], [3,4,6], [10,1,6], [8,3,7]])
//ninjaTraining(tasks: [[1,2,5], [3 ,1 ,1] ,[3,3,3]])
ninjaTraining(tasks: [[3 ,3 ,1] ,[3,3,3], [1,2,5]])

// MARK: Pseudo code Tabulization
// 1. We will calculate the maxPoints for day 0 for all the skipped activities
// 2. Create maxPoints = max of day 0 points
// 3. We will call for loop from day 1 to last day
// 4. Inside for loop,
// 5. We will calculate the points for day + day-1(this will come dp)
// 6. store them in dp
// 7. compare with max and store it in max

//Time Complexity: O(r*c*(c+1))
//Space Complexity: O(c+1)

func ninjaTrainingTabulization(tasks: [[Int]]) -> Int {
    var pointsTable: [Int] = []
    pointsTable.append(max(tasks[0][1], tasks[0][2]))
    pointsTable.append(max(tasks[0][0], tasks[0][2]))
    pointsTable.append(max(tasks[0][0], tasks[0][1]))
    pointsTable.append(max(tasks[0][0], max(tasks[0][1], tasks[0][2])))
    
    for day in 1..<tasks.count {
        var todayPoints = [0, 0, 0, 0]
        for lastTask in 0..<4 {
            for task in 0..<3 {
                if task != lastTask {
                    let points = tasks[day][task] + pointsTable[task]
                    todayPoints[lastTask] = max(todayPoints[lastTask], points)
                }
            }
        }
        pointsTable = todayPoints
    }
    
    print(pointsTable)
    return pointsTable[3]
}

//ninjaTrainingTabulization(tasks: [[1,2,5], [3 ,1 ,1] ,[3,3,3]])
ninjaTrainingTabulization(tasks: [[3 ,3 ,1] ,[3, 3, 3], [1, 2, 5]])

