/*
 Given an array of distinct integers candidates and a target integer target, return a list of all unique combinations of candidates where the chosen numbers sum to target. You may return the combinations in any order.

 The same number may be chosen from candidates an unlimited number of times. Two combinations are unique if the frequency of at least one of the chosen numbers is different.

 It is guaranteed that the number of unique combinations that sum up to target is less than 150 combinations for the given input.
 */

class Solution {
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var result = [[Int]]()
        makeCombinations(candidates.sorted(), 0, target, [], &result)
        return result
    }
    
    private func makeCombinations(_ candidates: [Int], _ initialIndex: Int,_  target: Int,_ tempArray: [Int], _ result:  inout [[Int]]) {
        if target == 0 {
            tempArray.sorted()
            if !result.contains(tempArray) {
                result.append(tempArray)
            }
            return
        }
        
        if initialIndex >= candidates.count || candidates[initialIndex] > target {
            return
        }
        
        var newArray = tempArray
        newArray.append(candidates[initialIndex])
        makeCombinations(candidates, initialIndex, target - candidates[initialIndex], newArray, &result)
        makeCombinations(candidates, initialIndex+1, target, tempArray, &result)
    }
}

let solution = Solution()
let input = [2,7,6,3,5,1]
let result = solution.combinationSum(input, 9)
print("Combination result: \(result)")
