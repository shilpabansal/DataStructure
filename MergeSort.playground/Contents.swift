import UIKit

class MergeSort {
    
    func mergeSort(array: [Int]) -> [Int] {
        if array.count <= 1 {
            return array
        }
        else {
            let mid = array.count/2
            let firstArray = mergeSort(array: Array(array[0...mid-1]))
            let secondArray = mergeSort(array: Array(array[mid...array.count-1]))
            
            let orderedArray = sortAndMergeArray(firstArray, secondArray)
            return orderedArray
        }
    }
    
    func sortAndMergeArray(_ array1: [Int], _ array2:[Int]) -> [Int] {
        var i = 0
        var j = 0
        var tempArray :[Int] = []
        while true {
            if array1[i] < array2[j] {
                tempArray.append(array1[i])
                i += 1
            }
            else {
                tempArray.append(array2[j])
                j += 1
            }
            
            if i == array1.count || j == array2.count {
                break
            }
        }
        while i < array1.count {
            tempArray.append(array1[i])
            i += 1
        }
        while j < array2.count {
            tempArray.append(array2[j])
            j += 1
        }
        return tempArray
    }
}

var mergeSort = MergeSort()
var array = [6, 4, 14, 2, 31, 57, 28, 61]

print(mergeSort.mergeSort(array: array))
