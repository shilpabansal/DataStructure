/*
 Given an integer array and a positive integer k, count all distinct pairs with differences equal to k.

 Input: arr[] = {1, 5, 3, 4, 2}, k = 3
 Output: 2
 There are 2 pairs with difference 3, the pairs are {1, 4} and {5, 2}

 Input: arr[] = {8, 12, 16, 4, 0, 20}, k = 4
 Output: 5
 There are 5 pairs with difference 4, the pairs are {0, 4}, {4, 8},
 {8, 12}, {12, 16} and {16, 20}
 
we can solve this problem with moving window algo
 
 For this firstly we can sort the array using Heap/Merge with nlogn complexity */

var inputArray = [ 8, 12, 16, 12, 4, 0, 4, 20 ]
print("inputArray: \(inputArray)")

var set = Set<Int>()
inputArray.forEach { element in
    set.insert(element)
}
inputArray = Array(set)

print("After removing duplicate values: \(inputArray)")

inputArray.sort()
print("After sorting: \(inputArray)")

let k = 12 //the difference to calculate


var pointerA = 0
var pointerB = 0
var pairCount = 0

let n = inputArray.count
while pointerA < n && pointerB < n {
    if inputArray[pointerB] - inputArray[pointerA] == k {
        pairCount += 1
        pointerA += 1
    }
    else if inputArray[pointerB] - inputArray[pointerA] < k {
        pointerB += 1
    }
    else {
        pointerA += 1
    }
}

print(pairCount)
