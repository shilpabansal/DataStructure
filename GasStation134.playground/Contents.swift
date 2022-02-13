class Solution {
    func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        if gas.count != cost.count {
            return -1
        }
        var index = 0
        while index < gas.count {
            if gas[index] >= cost[index] {
                let startIndex = index
                
                var currenIndex = startIndex
                var lastSum = gas[currenIndex]
                while true {
                    let nextIndex = currenIndex + 1 >= gas.count ? 0 : currenIndex + 1
                    if lastSum - cost[currenIndex] < 0 {
                        print("\(cost[currenIndex]) \(lastSum)")
                        break
                    }
                    lastSum += gas[nextIndex] - cost[currenIndex]
                    currenIndex = nextIndex
                    
                    if currenIndex == startIndex {
                        return startIndex
                    }
                }
            }
            index += 1
        }
        return -1
    }
}

//let gas = [1,2,3,4,5], cost = [3,4,5,1,2]
//let gas = [2,3,4], cost = [3,4,3]
let gas = [2], cost = [2]
let solution = Solution()
print(solution.canCompleteCircuit(gas, cost))
