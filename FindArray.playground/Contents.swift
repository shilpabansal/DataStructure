func findArray(array: [Int]) -> [Int] {
    var output = [Int]()
    var isFoundArray = [Bool](repeating: false, count: array.count)
    let sortedArray = array.sorted()
    for (index, element) in sortedArray.enumerated() {
        var index2 = index + 1
        
        if isFoundArray[index] {
            continue
        }
        
        while index2 < sortedArray.count {
            if 2 * element == sortedArray[index2] && !isFoundArray[index2]  {
                isFoundArray[index] = true
                isFoundArray[index2] = true
                
                output.append(element)
                break
            }
            index2 += 1
        }
    }
    return isFoundArray.allSatisfy({ $0 == true }) ? output : []
}

let result = findArray(array: [2, 4, 1, 8])
print(result)

// [1, 2, 3, 4, 6, 8]
