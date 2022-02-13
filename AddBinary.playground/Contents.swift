extension String {
    subscript(forIndex: Int) -> Character {
        return Array(self)[forIndex]
    }
}

class Solution {
    func convertToDecimal(_ a: String) -> Int {
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
    
    func decimalToBinary(_ a: Int) -> String {
        var result = ""
        var quotient = a
        
        while quotient > 0 {
            let reminder = quotient % 2
            result = "\(reminder)" + result
            quotient = quotient / 2
        }
        
        return result.isEmpty ? "0" : result
    }
    
    func addBinary1(_ a: String, _ b: String) -> String {
        let decimal1 = convertToDecimal(a)
        let decimal2 = convertToDecimal(b)
        
        return decimalToBinary(decimal1+decimal2)
    }
    
    func addBinary(_ a: String, _ b: String) -> String {
        var result = ""
        var carry = "0"
        
        var firstStringIndex = a.count - 1
        var secondStringIndex = b.count - 1
        
        while firstStringIndex >= 0 || secondStringIndex >= 0 {
            let firstChar = firstStringIndex >= 0 ? a[firstStringIndex] : "0"
            let secondChar = secondStringIndex >= 0 ? b[secondStringIndex] : "0"
            
            switch (firstChar, secondChar, carry) {
            case ("0", "0", "0"):
                carry = "0"
                result = "0" + result
                
            case ("1", "0", "0"),
                ("0", "1", "0"),
                ("0", "0", "1"):
                carry = "0"
                result = "1" + result
                
            case ("1", "1", "0"),
                ("1", "0", "1"),
                ("0", "1", "1"):
                carry = "1"
                result = "0" + result
                
            case ("1", "1", "1"),
                ("1", "1", "1"),
                ("1", "1", "1"):
                carry = "1"
                result = "1" + result
             
            default:
                break
            }
            
            firstStringIndex -= 1
            secondStringIndex -= 1
        }
        
        if carry == "1" {
            result = "1" + result
        }
        
        return result
    }
}

let solution = Solution()
let a = "1010"
let b = "1011"
let result = solution.addBinary1(a, b)
print("Addition of binaries \(a) and \(b) is result: \(result)")

let binaryInput = "1000"
print("Decimal result of \(binaryInput)  is \(solution.convertToDecimal(binaryInput))")

let decimalInput = 8
print("Binary result of \(decimalInput) is \(solution.decimalToBinary(decimalInput))")

