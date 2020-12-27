import UIKit


class Sort {
    func insertionSort(unsortedArray: Array<Int>) -> Array<Int> {
        var sortArray = unsortedArray
        for (i,key) in sortArray.enumerated() {
            var j = i - 1
            while(j >= 0) {
                if key < sortArray[j] {
                    sortArray.remove(at: j+1)
                    sortArray.insert(key, at: j)
                }
                j -= 1 ;
            }
        }
        return sortArray
    }
    
    func bubbleSort(unsortedArray: Array<Int>) -> Array<Int> {
        var sortArray = unsortedArray
        var k = 0
        
        while true {
            let i = 0
            
            for j in i..<sortArray.count - k - 1 {
                if sortArray[j] > sortArray[j+1] {
                    sortArray.swapAt(j, j+1)
                }
            }
            k += 1
            if k == sortArray.count - 2 {
                break
            }
        }
        return sortArray
    }
    
    
    func selectionSort(unsortedArray: Array<Int>) -> Array<Int> {
        var sortArray = unsortedArray
         for i in 0..<sortArray.count - 1 {
             for j in i+1..<sortArray.count {
                 if sortArray[i] > sortArray[j] {
                     sortArray.swapAt(i, j)
                 }
             }
        }
        return sortArray
    }
    
    func quickSort(_ unsortedArray: inout Array<Int>,_ startIndex : Int,_ lastIndex: Int) {
        if startIndex < lastIndex {
            let pivotIndex = quickSortSubArray(&unsortedArray, startIndex, lastIndex)
            quickSort(&unsortedArray, startIndex, pivotIndex - 1)
            quickSort(&unsortedArray, pivotIndex + 1, lastIndex)
        }
    }
    
    func quickSortSubArray(_ unsortedArray: inout Array<Int>,_ startIndex: Int,_ lastIndex: Int) -> Int {
        let pivot = unsortedArray[lastIndex]
        var i = startIndex
        var j = lastIndex - 1
        
        while true {
             while unsortedArray[i] < pivot && i < j {
                 i += 1
             }
             while unsortedArray[j] > pivot && i < j {
                 j -= 1
             }
             
             if i >= j {
                 if i == j && unsortedArray[i] < pivot {
                    return i + 1
                 }
                 unsortedArray.insert(unsortedArray[lastIndex], at: i)
                 unsortedArray.remove(at: lastIndex + 1)
                
                 break
             }
             else {
                 unsortedArray.swapAt(i, j)
                 i += 1
                 j -= 1
             }
             
        }
        return i
    }
    
    func mergerSort(_ unsortedArray: Array<Int>) -> Array<Int> {
        if unsortedArray.count == 1 {
            return unsortedArray
        }
        
        let middleIndex = unsortedArray.count / 2
        let unsortedArray1 = mergerSort(Array(unsortedArray[0..<middleIndex]))
        let unsortedArray2 = mergerSort(Array(unsortedArray[middleIndex..<unsortedArray.count]))
    
        return mergeSortSubArray(unsortedArray1, unsortedArray2)
    }
    
    func mergeSortSubArray(_ unsortedArray1: Array<Int>, _ unsortedArray2: Array<Int>) -> Array<Int> {
        var sortedArray :Array<Int> = []
        
        var i = 0, j = 0
        
        while i < unsortedArray1.count && j < unsortedArray2.count {
            if unsortedArray1[i] < unsortedArray2[j] {
                sortedArray.append(unsortedArray1[i])
                i += 1
            }
            else {
                sortedArray.append(unsortedArray2[j])
                j += 1
            }
        }
        while i < unsortedArray1.count {
            sortedArray.append(unsortedArray1[i])
            i += 1
        }
        while j < unsortedArray2.count {
            sortedArray.append(unsortedArray2[j])
            j += 1
        }
        return sortedArray
    }
    
    func heapSort(_ unsortedArray: Array<Int>) -> [Int] {
        var sortedArray : Array<Int> = []
        for (index, item) in unsortedArray.enumerated() {
            sortedArray.append(item)
            tuckleUp(&sortedArray, index: index)
        }
        return sortedArray
    }
    
    func tuckleUp(_ sortedArray: inout Array<Int>, index: Int) {
        if index >= 1 {
            let parentIndex = getParent(index: index)
            if sortedArray[index] < sortedArray[parentIndex] {
                sortedArray.swapAt(index, parentIndex)
            }
        }
    }
    
    func tuckleDown(_ unsortedArray: inout Array<Int>, index: Int) {
           let (childIndex1, childIndex2) = getChildren(index: index)
           if unsortedArray[index] < unsortedArray[childIndex1] {
               unsortedArray.swapAt(index, childIndex1)
           }
           else if unsortedArray[index] < unsortedArray[childIndex2] {
               unsortedArray.swapAt(index, childIndex2)
           }
       }
    
    func getParent(index: Int) -> Int {
        return (index - 1 ) / 2
    }
    
    func getChildren(index: Int) -> (Int, Int) {
        return (2 * index + 1, 2 * index + 2)
    }
}

var numberList : Array<Int> = [18, 2, 54, 20, 110, 92, 61, 42, 117, 53, 44]
numberList = [8, 2, 10, 9, 11, 1, 7, 3, 4]
var sort = Sort()

print("Insertion Sort : \(sort.insertionSort(unsortedArray: numberList))")
print("Bubble Sort    : \(sort.bubbleSort(unsortedArray: numberList))")

print("Selection Sort : \(sort.selectionSort(unsortedArray: numberList))")

var unsortArray = numberList
sort.quickSort(&unsortArray, 0, unsortArray.count - 1)
print("Quick Sort     : \(unsortArray)")

print("Merge Sort     : \(sort.mergerSort(numberList))")

print("Heap Sort      : \(sort.heapSort(unsortArray))")

