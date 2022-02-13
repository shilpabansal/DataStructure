/*
 Given a triangle array, return the minimum path sum from top to bottom.

 For each step, you may move to an adjacent number of the row below. More formally, if you are on index i on the current row, you may move to either index i or index i + 1 on the next row.

  

 Example 1:

 Input: triangle = [[2],[3,4],[6,5,7],[4,1,8,3]]
 Output: 11
 Explanation: The triangle looks like:
    2
   3 4
  6 5 7
 4 1 8 3
 The minimum path sum from top to bottom is 2 + 3 + 5 + 1 = 11 (underlined above).
 
 nextStepArray saves the value at each level which should be passed to previous levels
 
 for the max index, it saves the minimum value by comparing adjacent numbers: for 3rd index, it saved [1, 1, 3](4 > 1, 1 < 8, 8 > 3)
 Now for 2nd index: it adds the value coming from next index and saves it in nextStepArray [6+1, 5+1, 7+1] = [7, 6, 8], then again compare adjacent elements to pass the value to lower levels
 [6, 6] [7>6,6<8] is passed to 1st level
 
 again 1st level elements are added with next level elements and compared [6, 6] + [3, 4] = [9, 10], compare and saved [9] at 1st level
 
 at 0th level 2 is added to 9 and returned, Hence the result is 11
 */
class Solution {
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        var index = triangle.count - 1
        
        var nextStepArray = [Int]()
        while index >= 0 {
            var elementIndex = 0
            while elementIndex+1 < triangle[index].count {
                
                if index < triangle.count - 1 {
                    let left = triangle[index][elementIndex] + nextStepArray[elementIndex]
                    let right = triangle[index][elementIndex+1] + nextStepArray[elementIndex+1]
                    nextStepArray[elementIndex] = left < right ? left : right
                }
                else {
                    let minimumElement = (triangle[index][elementIndex] < triangle[index][elementIndex+1] ? triangle[index][elementIndex] : triangle[index][elementIndex+1])
                    nextStepArray.append(minimumElement)
                }
                elementIndex += 1
            }
            
            if index == 0 {
                if nextStepArray.count > elementIndex {
                    nextStepArray[elementIndex] += triangle[0][0]
                }
                else {
                    nextStepArray.append(triangle[0][0])
                }
            }
                                                
            index -= 1
        }
        return nextStepArray[0]
    }
}

let input = [[-1],[2,3],[1,-1,-3]]
let solution = Solution()
print(solution.minimumTotal(input))

