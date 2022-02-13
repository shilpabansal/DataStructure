/*
 Given two integers n and k, return all possible combinations of k numbers out of the range [1, n].

 You may return the answer in any order.
 */

class Solution {
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        var result = [[Int]]()
        
        if n == 0 {
            return result
        }
        
        combineArray(n, k, startIndex: 1, array: [], result: &result)
        return result
    }
    
    func combineArray(_ n: Int, _ k: Int, startIndex: Int, array: [Int], result: inout [[Int]]) {
        if array.count == k {
            if !result.contains(array) {
                result.append(array)
            }
            return
        }
        if startIndex > n {
            return
        }
        
        combineArray(n, k, startIndex: startIndex + 1, array: array, result: &result)
        
        var array = array
        if !array.contains(startIndex) {
            array.append(startIndex)
        }
        combineArray(n, k, startIndex: startIndex + 1, array: array, result: &result)
    }
}

let solution = Solution()
let n = 4
let k = 2
print(solution.combine(n, k))
