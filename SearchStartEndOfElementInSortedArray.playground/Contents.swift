class Solution {
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        var result = [-1, -1]
        let endIndex = nums.count - 1
        if nums.count == 0 || nums[0] > target || nums[endIndex] < target {
            return result
        }
        
        if nums[0] == target  {
            result[0] = 0
        }
        
        if nums[endIndex] == target {
            result[1] = endIndex
        }
        findMinIndex(nums, target, start: 0, end: endIndex, result: &result)
        
        if result[0] == -1 && result[1] != -1 {
            result[0] = result[1]
        }
        if result[1] == -1 && result[0] != -1 {
            result[1] = result[0]
        }
        return result
    }
    
    private func findMinIndex(_ nums: [Int], _ target: Int, start: Int, end: Int, result: inout [Int]) {
        if start < 0 || end > nums.count || start > nums.count || end < 0 || end < start {
            return
        }
        
        var mid = (start + end) / 2
        
        if (mid-1 > 0 && nums[mid-1] < target && nums[mid] > target) ||
            (mid+1 < nums.count && nums[mid] < target && nums[mid + 1] > target) {
            return
        }
        if nums[mid] > target {
            if mid-1 > 0 && nums[mid-1] == target {
                result[1] = mid-1
                if result[0] != -1 && result[1] != -1 {
                    return
                }
            }
            findMinIndex(nums, target, start: start, end: mid-1, result: &result)
        }
        else if nums[mid] < target {
            if mid+1 < nums.count && nums[mid+1] == target {
                result[0] = mid+1
                if result[0] != -1 && result[1] != -1 {
                    return
                }
            }
            findMinIndex(nums, target, start: mid+2, end: end, result: &result)
        }
        else {
            if start == end {
                if result[0] == -1 {
                    result[0] = start
                }
                if result[1] != -1 {
                    result[1] = start
                }
                return
            }
            if result[0] == -1 {
                if mid-1 > 0 && nums[mid-1] < target {
                    result[0] = mid
                    if result[1] != -1 {
                        return
                    }
                }
                else {
                    findMinIndex(nums, target, start: 0, end: mid-1, result: &result)
                }
            }
            
            if result[1] == -1 {
                if mid+1 < nums.count && nums[mid+1] > target {
                    result[1] = mid
                    if result[0] != -1 {
                        return
                    }
                }
                else {
                    findMinIndex(nums, target, start: mid + 1, end: nums.count - 1, result: &result)
                }
            }
        }
        mid = (start + end) / 2
    }
}
