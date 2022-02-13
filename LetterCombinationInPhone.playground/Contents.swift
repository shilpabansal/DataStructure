class Solution {
    func letterCombinations(_ digits: String) -> [String] {
        let dict = [2: "abc",
                    3: "def",
                    4: "ghi",
                    5: "jkl",
                    6: "mno",
                    7: "pqrs",
                    8: "tuv",
                    9: "wxyz"]
        
        var stringArray = [String]()
        for char in digits {
            if let intValue = char.wholeNumberValue,
               let str = dict[intValue] {
                stringArray.append(str)
            }
        }
        return getCombination(stringArray)
    }
    
    private func getCombination(_ stringArray: [String]) -> [String] {
        var result = [String]()
        for (index, str) in stringArray.enumerated() {
            var interResult = [String]()
            for char in str {
                if index == 0 {
                    result.append("\(char)")
                }
                else {
                    for element in result {
                        interResult.append("\(element)\(char)")
                    }
                }
            }
            if index != 0 {
                result = interResult
            }
        }
        return result
    }
}

let digits = "29"
let solution = Solution()
print(solution.letterCombinations(digits))
