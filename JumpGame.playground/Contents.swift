/*
 Given an array of non-negative integers nums, you are initially positioned at the first index of the array.

 Each element in the array represents your maximum jump length at that position.

 Your goal is to reach the last index in the minimum number of jumps.

 You can assume that you can always reach the last index.

  

 Example 1:

 Input: nums = [2,3,1,1,4]
 Output: 2
 Explanation: The minimum number of jumps to reach the last index is 2. Jump 1 step from index 0 to 1, then 3 steps to the last index.
 Example 2:
 As jump from 3, takes single jump to reach to 4. 2 -> 3 -> 4 (2 jumps)

 Input: nums = [2,3,0,1,4]
 Output: 2
 
 Solution:
 Starting from last position, update the number of possible jumps
 */

class Solution {
    func minimumJumps(_ nums: [Int]) -> Int {
        let arrayLastIndex = nums.count - 1
        var minJumps = [Int](repeating: 10000, count: nums.count)
        
        var currentIndex = arrayLastIndex
        minJumps[currentIndex] = 0
        
        while currentIndex >= 0 {
            let currentJumpValue = nums[currentIndex]
            
            var jumpingIndex = currentJumpValue
            while jumpingIndex > 0 {
                if  currentIndex >= arrayLastIndex  {
                    break
                }
                
                // If jumped index is more than the last index, consider it last index
                let jumpedIndex = (jumpingIndex + currentIndex > arrayLastIndex) ? arrayLastIndex : (jumpingIndex + currentIndex)
                let minJump = 1 + minJumps[jumpedIndex]
                if minJump < minJumps[currentIndex] {
                    minJumps[currentIndex] = minJump
                }
                
                jumpingIndex -= 1
            }
           
            currentIndex -= 1
            
        }
        print("Min Array is: \(minJumps)")
        return minJumps[0]
    }
}

//let input = [2, 3, 1, 1, 4, 5, 6]
let input = [ 1, 2, 1, 1, 1, 4, 4, 1, 5, 2, 3, 4, 1, 4, 2, 5, 2, 6, 4, 4, 2, 2, 5, 6, 2, 3, 4, 5, 4, 4, 2, 3, 1, 4, 1, 6, 2, 3, 5, 3, 6, 6, 1, 2, 5, 3, 3, 4, 6, 1, 1, 5, 3, 3, 4, 5, 1, 4, 2, 6, 6, 4, 1, 4, 1, 2, 1, 4, 4, 2, 1, 2, 2, 5, 6, 5, 4, 4, 3, 6, 5, 2, 5, 6, 1, 4, 3, 4, 3, 3, 1, 2, 6, 5, 3, 6, 1, 2, 6, 4, 2, 3, 3, 4, 6, 3, 5, 3, 2, 3, 3, 1, 3, 2, 4, 1, 3, 5, 1, 1, 5, 2, 4, 2, 2, 5, 3, 4, 2, 1, 3, 3, 1, 2, 4, 5, 4, 6, 2, 5, 6, 4, 6, 5, 2, 2, 1, 4, 6, 4, 2, 4, 1, 6, 3, 3, 6, 1, 4, 5, 4, 5, 1, 2, 3, 6, 1, 4, 3, 2, 5, 1, 5, 2, 5, 1, 2, 3, 3, 6, 6, 3, 5, 2, 6, 1, 6, 4, 3, 4, 1, 2, 5, 1, 5, 6, 5, 3, 1, 5, 6, 3, 6, 3, 5, 6, 2, 2, 6, 3, 4, 1, 4, 1, 1, 3, 4, 1, 5, 6, 5, 4, 2, 5, 3, 6, 4, 1, 2, 3, 5, 6, 5, 2, 3, 6, 1, 3, 4, 6, 3, 2, 5, 5, 1, 6, 6, 6, 2, 3, 5, 5, 4, 5, 2, 1, 6, 6, 2, 5, 1, 3, 2, 5, 1, 2, 3, 4, 1, 1, 5, 1, 4, 1, 2, 2, 6, 1, 4, 3, 2, 1, 6, 5, 1, 6, 2, 3, 5, 3, 6, 6, 5, 2, 1, 4, 4, 5, 3, 5, 5, 1, 3, 2, 6, 1, 6, 6, 4, 6, 5, 3, 3, 1, 6, 2, 6, 4, 2, 4, 1, 2, 2, 2, 2, 1, 5, 4, 3, 6, 3, 2, 5, 5, 4, 6, 4, 1, 5, 2, 4, 6, 2, 4, 5, 5, 3, 4, 6, 6, 1, 6, 6, 5, 3, 1, 4, 6, 5, 3, 5, 3, 5, 2, 3, 4, 6, 2, 5, 6, 6, 2, 5, 6, 1, 1, 5, 4, 5, 6, 6, 5, 5, 3, 3, 4, 4, 5, 2, 6, 5, 1, 3, 2, 3, 1, 3, 1, 2, 3, 5, 2, 5, 3, 2, 2, 3, 4, 4, 2, 6, 5, 1, 3, 4, 6, 1, 6, 4, 4, 2, 4, 5, 2, 5, 6, 6, 1, 3, 1, 1, 4, 6, 5, 6, 4, 1, 3, 1, 1, 6, 2, 6, 4, 5, 5, 3, 5, 3, 6, 6, 2, 1, 3, 2, 5, 5, 3, 5, 3, 3, 5, 3, 2, 1, 2, 2, 6, 1, 6, 4, 2, 2, 2, 6, 2, 4, 2, 5, 5, 2, 3, 1, 1, 5, 6, 6, 3, 4, 6, 2, 1, 2, 1, 4, 2, 5, 6, 5, 5, 3, 2, 1, 5, 1, 3, 2, 2, 5, 1, 6, 1, 6, 5, 6, 2, 6, 3, 6, 5, 1, 4, 6, 3, 3, 6, 6, 4, 1, 4, 6, 3, 4, 1, 4, 2, 5, 5, 5, 4, 2, 5, 6, 6, 3, 1, 5, 4, 2, 3, 6, 1, 6, 4, 1, 5, 5, 6, 4, 5, 4, 4, 6, 5, 2, 5, 1, 4, 3, 2, 6, 1, 5, 2, 6, 2, 6, 1, 2, 3, 5, 5, 4, 4, 5, 4, 2, 1, 4, 1, 4, 6, 1, 1, 2, 6, 2, 3, 6, 4, 4, 5, 6, 6, 4, 1, 6, 3, 2, 4, 1, 4, 5, 5, 2, 6, 6, 4, 2, 5, 4, 6, 6, 5, 2, 4, 1, 1, 4, 1, 1, 4, 6, 1, 5, 2, 4, 6, 5, 1, 6, 6, 6, 2, 1, 6, 1, 5, 5, 4, 5, 2, 3, 2, 2, 2, 6, 4, 6, 2, 4, 6, 4, 5, 1, 3, 2, 4, 2, 6, 6, 4, 3, 3, 1, 1, 4, 4, 5, 5, 4, 1, 6, 5, 1, 3, 3, 6, 5, 5, 3, 6, 3, 5, 2, 4, 3, 4, 6, 5, 2, 6, 6, 1, 2, 3, 4, 6, 1, 5, 6, 4, 6, 6, 1, 1, 2, 4, 6, 4, 1, 1, 6, 6, 2, 1, 1, 2, 3, 6, 5, 3, 1, 6, 1, 3, 6, 2, 4, 5, 3, 2, 5, 3, 5, 5, 2, 1, 3, 4, 4, 6, 2, 4, 3, 3, 1, 5, 3, 3, 1, 2, 5, 2, 5, 2, 2, 4, 2, 2, 4, 6, 3, 1, 4, 2, 3, 4, 2, 2, 6, 3, 2, 6, 3, 3, 5, 5, 5, 2, 3, 1, 6, 5, 4, 5, 2, 6, 5, 2, 1, 2, 2, 2, 2, 2, 3, 2, 6, 3, 1, 5, 6, 1, 4, 6, 5, 3, 3, 5, 5, 6, 5, 1, 4, 3, 5, 5, 3, 4, 6, 4, 6, 3, 2, 1, 1, 6, 2, 2, 5, 5, 3, 1, 3, 5, 6, 3, 6, 2, 5, 6, 2, 1, 4, 4, 2, 2, 6, 2, 1, 5, 6, 1, 1, 3, 3, 5, 5, 3, 2, 5, 2, 1, 3, 2, 4, 3, 5, 2, 5, 5, 4, 1, 1, 3, 4, 3, 1, 3, 5, 5, 4, 5, 5, 1, 3, 5, 4, 6, 5, 4, 2, 1, 2, 6, 6, 4, 4, 5, 6, 6, 6, 3, 4, 3, 5, 2, 5, 6, 5, 2, 1, 4, 5, 3, 1, 6, 4, 1, 5, 4, 5, 2, 5, 1, 4, 2, 6, 3, 3, 5, 1, 3, 4, 3, 3, 6, 6, 5, 5, 5, 4, 5, 3, 6, 6, 6, 4, 2, 4, 4, 1, 2, 2, 2, 3, 2, 2, 5, 6, 5, 6, 3, 3, 1, 1, 4, 1, 6, 6, 5, 3, 2, 6, 5, 2, 1, 6, 1, 4, 6, 4, 1, 2, 1, 2, 5, 1, 1, 6, 3, 2, 5, 4, 5, 2, 6, 5, 6, 2, 2, 1, 5, 5, 1, 6, 2, 1, 3, 4, 5, 4, 3, 1, 5, 6, 5, 4, 1, 2, 3, 4, 2, 2, 6, 2, 4, 3, 2, 5, 3, 2, 2, 5, 6, 3, 3, 2, 1, 4, 5, 2, 3, 2, 5, 3, 1, 3, 6, 3, 6, 4, 2, 5, 3, 6, 1, 6, 5, 2, 1, 5, 2, 1, 1, 4, 3, 3, 1, 1, 2, 2, 1, 1, 4, 1, 6, 5, 5, 6, 4, 6, 6, 2, 2, 2, 6, 1, 1, 1, 1, 5, 2, 2, 1, 6, 5, 6, 1, 3, 1, 6, 4, 1, 2, 1, 5, 1, 1, 3, 6, 4, 5, 4, 2, 3, 4, 1, 5, 2, 2, 1, 6, 2, 3, 2, 3, 3, 1, 1, 4, 5, 5, 3, 5, 3, 6, 4, 5, 4, 4, 4, 2, 2, 1, 4, 6, 0, 0, 0, 0, 0]
let solution = Solution()
print("The input array is \(input)")
print("The min jump from 0 to last index is : \(solution.minimumJumps(input))")
