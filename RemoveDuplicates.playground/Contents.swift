class Solution {
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        var count = 0
        var startIndex = 0
        
        var lastChar = nums[0]
        while startIndex < nums.count {
            print("startIndex \(startIndex) \(lastChar) \(nums)")
            if lastChar == nums[startIndex] {
                count += 1
                startIndex += 1
            }
            else {
                print("count:\(count) startIndex:\(startIndex)")
                if count > 2 {
                    let startRange = startIndex - (count-2)
                    let endRange = startIndex - 1
                    print("startRange:\(startRange) endRange:\(endRange)")
                    nums.removeSubrange(startRange...endRange)
                    startIndex = startRange
                }
                lastChar = nums[startIndex]
                startIndex += 1
                count = 1
            }
        }
        if count > 2 {
            let startRange = nums.count - (count-2)
            let endRange = nums.count - 1
            nums.removeSubrange(startRange...endRange)
        }
        print(count)
        return nums.count
    }
}

let solution = Solution()
var input = [1,1,1, 1, 1]

//var input = [1,1,1,1,1,2,3,3]
print(solution.removeDuplicates(&input))
