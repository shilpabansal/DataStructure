extension String {
    subscript(index: Int) -> Character {
        return Array(self)[index]
    }
}

class Solution {
    func singleNumber(_ nums: [Int]) -> Int {
        let binaryArray = nums.map({ decimalToBinary($0) })
        let maxLength = binaryArray.max(by: { $0.count < $1.count } )?.count ?? 0
        var index = 0
        var tempString = ""
                
        while index < maxLength {
            var sumOfZeros = 0
            var sumOfOnes = 0
            for str in binaryArray {
                let currentIndex = str.count - index - 1
                
                if currentIndex >= 0 {
                    if str[currentIndex] == "0" {
                        sumOfZeros += 1
                    }
                    else if str[currentIndex] == "1" {
                        sumOfOnes += 1
                    }
                }
            }
            let currentValue = sumOfZeros % 3 == 0 ? "1" : "0"
            tempString = "\(currentValue)\(tempString)"
            index += 1
        }
        
        return convertToDecimal(tempString)
    }
    
    private func decimalToBinary(_ a: Int) -> String {
        var result = ""
        var quotient = a
        
        while quotient > 0 {
            let reminder = quotient % 2
            result = "\(reminder)" + result
            quotient = quotient / 2
        }
        
        return result.isEmpty ? "0" : result
    }
    
    private func convertToDecimal(_ a: String) -> Int {
        var result = 0
        var index = a.count - 1
        while index >= 0 {
            let indexFromRight = a.count - 1 - index
            
            var temp = 1
            for _ in 0..<indexFromRight {
                temp *= 2
            }
            
            //Ascii value from 0-9 is 48-57
            if let ascii = a[index].asciiValue {
                temp *= Int(ascii) - 48
            }
            result = temp + result
            
            index -= 1
        }
        return result
    }
}
let nums = [0,1,0,1,0,1,99]
let solution = Solution()
print(solution.singleNumber(nums))
