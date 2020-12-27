import UIKit

/**
 NOT COMPLETED
 
 Inputs:
 k no of sorted array
 n no of elements in array
 
 solution: make heap of size k by taking first element from each array, get the min element from heap and add it in output array, increment the counter of the array from where the item is added
 
 */

class MergeSortedArray {
    func mergeSortedArray(inputArray: [[Int]]) -> [Int] {
        let k = 4
        let n = 5
        var indexArray = [Int](repeating: 0, count: k)
        var outputArray = [Int]()
        
        var minHeap = [(Int, Int)]()
                
        for i in 0..<k {
            minHeap.append((inputArray[i][0], i))
        }
        minHeap = makeMinHeap(array: minHeap)
        
        while outputArray.count <= k * n {
            let minObject = minHeap.remove(at: 0)
            outputArray.append(minObject.0)
            indexArray[minObject.1] = indexArray[minObject.1] + 1
            
            let i = minObject.1
            let j = indexArray[minObject.1]
            
            if j >= inputArray[i].count {
                continue
            }
            minHeap.append((inputArray[i][j], i))
            
            heapify(heapArray: &minHeap, index: minHeap.count - 1)
            
            print("outputArray:\(outputArray)")
        }
    
        return []
    }
    
    func heapify(heapArray: inout [(Int, Int)], index: Int) {
        var index = index
        var parent : Int = (index - 1) / 2
            while parent >= 0 && heapArray[parent].0 > heapArray[index].0 {
                       
                let temp = heapArray[parent]
                heapArray[parent] = heapArray[index]
                heapArray[index] = temp
                       
                index = parent
                parent = (index - 1) / 2
            }
    }
    
    func makeMinHeap(array: [(Int, Int)]) -> [(Int, Int)] {
        var heapArray = [(Int, Int)]()
        
        for index in 0..<array.count {
            heapArray.append(array[index])
            
            heapify(heapArray: &heapArray, index: index)
        }
        return heapArray
    }
}

var obj = MergeSortedArray()
var inputArray = [[-5, 23, 43, 90, 221], [24, 25, 45, 57, 67], [28, 34, 54, 60, 86], [29, 31, 32, 46, 59]]
print("inputArray:\(inputArray)")
obj.mergeSortedArray(inputArray: inputArray)


