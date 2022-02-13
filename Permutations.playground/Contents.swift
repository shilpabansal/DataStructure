class Solution {
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        if nums.count == 1 || nums.count == 0 {
            return [nums]
        }
        
        var firstIndex = 0
        while firstIndex < nums.count {
            let array1 = [nums[firstIndex]]
            let array2 = getArray(nums, without: firstIndex)
            
            let permutationOfArray2 = permuteUnique(array2)
            permutationOfArray2.forEach { permutations in
                let newResult = array1 + permutations
                
                if !result.contains(newResult) {
                    result.append(newResult)
                }
            }
            firstIndex += 1
        }
        
        return result
    }
    
    //Returns the same array without given index
    private func getArray(_ nums: [Int], without index: Int) -> [Int] {
        let result = nums.enumerated().compactMap { (arrayIndex, element) -> Int? in
            if arrayIndex != index {
                return element
            }
            return nil
        }
        return result
    }
}


let input = [1, 1, 2]
print("input array is: \(input)")
let solution = Solution()
let result = solution.permuteUnique(input)
print("result: \(result)")

