class RomanNumber {
    let HIGHEST_NUMBER = 3999
    let symbols = [ 1: "",
                    4: "IV",
                    5: "V",
                    9: "IX",
                   10: "X",
                   40: "XL",
                   50: "L",
                   90: "XC",
                   100: "C",
                   400: "CD",
                   500: "D",
                   900: "CM",
                   1000: "M"]
    
    private func baseValue(_ input: Int) -> Int {
        var dividend = input
        var count = 1
        while dividend != 0 {
            dividend /= 10
            count *= 10
        }
        return count/10
    }

    func calculateRomanValue(inputNumber: Int) -> String {
        var remainder = inputNumber
        var str = ""
        var multiplier = 1
        var quotient = 1

        let multipliers = [9, 5, 4, 1]
        while remainder > 0 {
            if remainder > HIGHEST_NUMBER {
                str = "UnKnown"
                break
            }
            let base = baseValue(remainder)
            
            for value in multipliers {
                if remainder >= base * value  {
                    multiplier = base * value
                    
                    quotient = remainder/multiplier
                    for _ in 0..<quotient {
                        if let symbol = symbols[multiplier] {
                            str += "\(symbol)"
                        }
                    }
                    remainder = remainder - (quotient * multiplier)
                    break
                }
            }
        }
        return str
    }
}

let romanNumber = RomanNumber()
let inputNumber = 3549
let romanValue = romanNumber.calculateRomanValue(inputNumber: inputNumber)
print("Roman value for \(inputNumber) is \(romanValue)")
