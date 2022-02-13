class Solution {
    func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        
        subsets(nums, startIndex: 0, array: [], result: &result)
        return result
    }
    
    private func subsets(_ nums: [Int], startIndex: Int, array: [Int], result: inout [[Int]]) {
        var array = array.sorted()
        if !result.contains(array) {
            result.append(array)
        }
        if startIndex >= nums.count {
            return
        }

        subsets(nums, startIndex: startIndex + 1, array: array, result: &result)
        
        array.append(nums[startIndex])
        
        subsets(nums, startIndex: startIndex + 1, array: array, result: &result)
    }
}

let input = [4,4,4,1,4]
let solution = Solution()
let result = solution.subsetsWithDup(input)
print(result)
