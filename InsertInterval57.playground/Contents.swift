import Foundation
class Solution {
    func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
        var result = [[Int]]()
        
        var lowInterval = newInterval[0]
        var highInterval = newInterval[1]
        
        var isNewIntervalAppended = false
        for interval in intervals {
            if interval[0] < newInterval[0] && interval[1] < newInterval[0] {
                result.append(interval)
            }
            else if (interval[0] > newInterval[1] && interval[1] > newInterval[1]) {
                if !isNewIntervalAppended {
                    result.append([lowInterval, highInterval])
                    isNewIntervalAppended = true
                }
                result.append(interval)
            }
            else {
                if interval[0] > newInterval[0] && interval[1] < newInterval[1] {
                    continue
                }
                
                lowInterval = interval[0] < lowInterval ? interval[0] : lowInterval
                highInterval = interval[1] > highInterval ? interval[1] : highInterval
                
                print("lowInterval:\(lowInterval) highInterval:\(highInterval)")
            }
        }
        
        if !isNewIntervalAppended {
            result.append([lowInterval, highInterval])
        }
        
        return result
    }
}

let solution = Solution()
let input = [[1,2],[3,5],[6,7],[8,10],[12,16]]
let interval = [4, 8]
print(solution.insert(input, interval))
