class Solution {
    
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        let MIN_VALUE = -10000
        let firstArrayCount = nums1.count
        let secondArrayCount = nums2.count
        let totalCount = firstArrayCount + secondArrayCount
        
        let midIndex = getMedianIndex(count: totalCount).mid
        let midMinusIndex = getMedianIndex(count: totalCount).midMinus
        print("midIndex:\(midIndex) midMinusIndex:\(midMinusIndex)")
        var mid = MIN_VALUE
        var midMinus = MIN_VALUE
        
        if firstArrayCount == 0 {
            if midMinusIndex != -1 {
                midMinus = midMinusIndex > 0 ? nums2[midMinusIndex-1] : nums2[0]
            }
            mid = midIndex > 0 ? nums2[midIndex-1] : nums2[0]
        }
        else if secondArrayCount == 0 {
            if midMinusIndex != -1 {
                midMinus = midMinusIndex > 0 ? nums1[midMinusIndex-1] : nums1[0]
            }
            mid = midIndex > 0 ? nums1[midIndex-1] : nums1[0]
        }
        else if nums1[firstArrayCount-1] <= nums2[0] {
            if midMinusIndex != -1 {
                midMinus = midMinusIndex >= firstArrayCount ? nums2[midMinusIndex-secondArrayCount] : nums1[midMinusIndex]
            }
            mid = midIndex >= firstArrayCount ?  nums2[midIndex-secondArrayCount] : nums1[midIndex]
        }
        else if nums2[secondArrayCount-1] <= nums1[0] {
            if midMinusIndex != -1 {
                midMinus = midMinusIndex >= secondArrayCount ? nums1[midMinusIndex-firstArrayCount] : nums2[midMinusIndex]
            }
            mid = midIndex >= secondArrayCount ?  nums2[midIndex-firstArrayCount] : nums2[midIndex]
        }
        else {
            var currentIndex = 0
            
            var l1 = 0
            var r1 = 0
            while mid == MIN_VALUE {
                if nums1[l1] <= nums2[r1] {
                    if currentIndex == midIndex {
                        mid = nums1[l1]
                    }
                    if midMinusIndex != -1 && currentIndex == midMinusIndex-1 {
                        midMinus = nums1[l1]
                    }
                    l1 += 1
                }
                else {
                    if currentIndex == midIndex {
                        mid = nums2[r1]
                    }
                    if midMinusIndex != -1 && currentIndex == midMinusIndex-1 {
                        midMinus = nums2[r1]
                    }
                    r1 += 1
                }
                if mid == MIN_VALUE && l1 == firstArrayCount {
                    if midMinusIndex != -1 {
                        midMinus = nums2[midMinusIndex-l1-1]
                    }
                    
                    mid = nums2[midIndex-l1-1]
                }
                if mid == MIN_VALUE && r1 == secondArrayCount {
                    if midMinusIndex != -1 {
                        midMinus = nums1[midMinusIndex-r1-1]
                    }
                    mid = nums1[midIndex-r1-1]
                }
                currentIndex += 1
            }
        }
        let median = midMinusIndex != -1 ? (Double(mid) + Double(midMinus))/2 : Double(mid)
        return median
    }
    
    //Returns a tuple for medianIndex
    private func getMedianIndex(count: Int) -> (mid: Int, midMinus: Int) {
        if count%2 == 0 {
            return (mid: count/2, midMinus: ((count/2) - 1))
        }
        else {
            return (mid: Int((count-1)/2), midMinus: -1)
        }
    }
}

let solution = Solution()
let result = solution.findMedianSortedArrays([0,0,0,0,0], [-1,0,0,0,0,0,1])
print("Median is: \(result)")

