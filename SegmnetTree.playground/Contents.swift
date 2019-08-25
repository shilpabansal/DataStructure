import UIKit

class SegmentTree {
    func constructTree(array: [Int], segTree: inout [Int], low: Int, high: Int, pos: Int) {
        if low == high {
            segTree[pos] = array[low]
            return
        }
        let mid = (low + high ) / 2
        constructTree(array: array, segTree: &segTree, low: low, high: mid, pos: 2 * pos + 1)
        constructTree(array: array, segTree: &segTree, low: mid + 1, high: high, pos: 2 * pos + 2)
        segTree[pos] = min(array[low], array[high])
    }
    
    func searchRangeInTree(segTree: [Int], lowQuery: Int, highQuery: Int, low: Int, high: Int, pos: Int) -> Int {
        if lowQuery <= low && highQuery >= high {//Full overlap
            return segTree[pos]
        }
        else if lowQuery > high || highQuery < low { // No oveerlap
            //if the range is out of bound, returning some max value
            return 100000
        }
        else { // Partial oveerlap
            let mid = (low + high ) / 2
            return min(searchRangeInTree(segTree: segTree, lowQuery: lowQuery, highQuery: highQuery, low: low, high: mid, pos: 2 * pos + 1), searchRangeInTree(segTree: segTree, lowQuery: lowQuery, highQuery: highQuery, low: mid + 1, high: high, pos: 2 * pos + 2))
        }
    }
}

let array = [10, 0, 3, -1, 5, 4, -9, -13, -15]

//Intialiazing with 100000, considering this is some impossible value or array's highest value can be taken initially
var tree : [Int] = Array(repeating: 100000, count: array.count * 2 - 1)
var segmentTree = SegmentTree()
segmentTree.constructTree(array: array, segTree: &tree, low: 0, high: array.count - 1, pos: 0)

let minValue = segmentTree.searchRangeInTree(segTree: tree, lowQuery: 4, highQuery: 7, low: 0, high: array.count - 1, pos: 0)
print("minValue: \(minValue)")

/**
 If the problem is to calculate max, then for no overlap and intial values min of int can be considered
 If the problem is to calculate sum of no, then 0 should be passed for no overlap condition
 */
