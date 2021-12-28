extension String {
   func charAt(index: Int) -> Character {
        let stringArray = Array(self)
        return stringArray[index]
    }
    
    subscript(index: Int) -> Character {
       return charAt(index: index)
    }
}

class Solution {
    func convert(_ s: String, _ numRows: Int) -> String {
        var resultString = ""
        var currentRow = 0
        if s.count <= numRows || numRows == 1 {
            return s
        }
        while currentRow < numRows {
            var charIndex = currentRow
            
            var isEvenPlacement = true
            while charIndex < s.count {
                resultString += "\(s[charIndex])"

                var addIndex = 0
                if currentRow == 0 || currentRow == numRows - 1 {
                    addIndex = (numRows - 1) * 2
                }
                else {
                    if isEvenPlacement {
                        addIndex = (numRows - 1 - currentRow) * 2
                    }
                    else {
                        addIndex = currentRow * 2
                    }
                }
                charIndex += addIndex
                isEvenPlacement = !isEvenPlacement
            }
            currentRow += 1
        }
        return resultString
    }
}

let solution = Solution()
let givenString = "AB"
let numberOfRows = 1
let result = solution.convert(givenString, numberOfRows)
print("For given string: \(givenString) the zigzag string is \(result) for \(numberOfRows) row")
