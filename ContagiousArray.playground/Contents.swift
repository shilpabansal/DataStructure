class Solution {
    func findMaxLength(_ nums: [Int]) -> Int {
        var count = 0
        
        var nums = nums
        
        for index in 0..<nums.count {
            if nums[index] == 0 {
                nums[index] = -1
            }
        }
        
        
        var sumArray = [Int](repeating: 0, count: nums.count)
        
        var index = 0
        
        while index < nums.count {
            if index == 0 {
                sumArray[index] = nums[index]
                index += 1
                continue
            }
            sumArray[index] = sumArray[index-1] + nums[index]
            index += 1
        }
        
        print(sumArray)
        var dict = [Int: Int]()
        
        for (index, element) in sumArray.enumerated() {
            if element == 0 {
                let newWindowSize = index + 1
                if count < newWindowSize {
                    count = newWindowSize
                }
                print("element 0 count: \(count)")
            }
            
            if dict[element] == nil {
                dict[element] = index
                print("index:\(index) element: \(element)")
            }
            else {
                let preIndex = dict[element]!
                let newWindowSize = index - preIndex
                
                print("preIndex:\(preIndex) index:\(index) newWindowSize: \(newWindowSize) count:\(count)")
                if count < newWindowSize {
                    count = newWindowSize
                }
            }
        }
        return count
    }
}

let input = [0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0]
let solution = Solution()
print(solution.findMaxLength(input))
