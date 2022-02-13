class Solution {
    let MAX_NUMBER = 10000
    func nextPermutation(_ nums: inout [Int]) {
        var i = 0
        var firstIndex = MAX_NUMBER
        var secondIndex = MAX_NUMBER
        while i < nums.count {
            var j = i + 1
            while j < nums.count {
                if nums[i] < nums[j] {
                    firstIndex = i
                    secondIndex = j
                }
                j += 1
            }
            i += 1
        }
        
        print("firstIndex:\(firstIndex) secondIndex:\(secondIndex)")
        if firstIndex == MAX_NUMBER && secondIndex == MAX_NUMBER {
            nums.sort()
            return
        }
        
        let temp = nums[firstIndex]
        nums[firstIndex] = nums[secondIndex]
        nums[secondIndex] = temp
        
        let sortedArray = Array(nums[firstIndex+1..<nums.count]).sorted()
        nums.removeLast((nums.count - firstIndex - 1))
        nums.append(contentsOf: sortedArray)
    }
}

let solution = Solution()
var input = [1, 2 , 5, 32, 4, 67, 89, 13]
print("input: \(input)")
solution.nextPermutation(&input)
print("Result: \(input)")
