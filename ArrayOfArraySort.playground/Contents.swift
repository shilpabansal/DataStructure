import UIKit

let list = [[1, 5, 7], [0, 3, 10], [4, 6, 9], [8, 11, 19]]

let k = 4
let n = 3

var outputArray = [Int]()
var indices = [-1, -1, -1, -1]

var smallestElement = 100
var arrrayIndex = -1

while outputArray.count < (k * n) {
    for index in 0..<list.count {
        let innerArrayIndex = indices[index] + 1
        if innerArrayIndex == n {
            continue
        }
        if list[index][innerArrayIndex] < smallestElement {
            smallestElement = list[index][innerArrayIndex]
            arrrayIndex = index
        }
    }
    indices[arrrayIndex] = indices[arrrayIndex] + 1
    outputArray.append(smallestElement)
    
    smallestElement = 100
}

print(outputArray)

