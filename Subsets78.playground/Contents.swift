/*
 Given two integers n and k, return all possible combinations of k numbers out of the range [1, n].

 You may return the answer in any order.
 */

class Solution {
    func subsets(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        if nums.count == 0 {
            return result
        }
        
        combineArray(nums, startIndex: 0, array: [], result: &result)
        return result
    }
    
    func combineArray(_ nums: [Int], startIndex: Int, array: [Int], result: inout [[Int]]) {
        if !result.contains(array) {
            result.append(array)
        }
        
        if startIndex >= nums.count {
            return
        }
        
        combineArray(nums, startIndex: startIndex+1, array: array, result: &result)
        
        var array = array
        if !array.contains(nums[startIndex]) {
            array.append(nums[startIndex])
        }

        combineArray(nums, startIndex: startIndex+1, array: array, result: &result)
    }
}

let solution = Solution()
let input = [0]
print(solution.subsets(input))
