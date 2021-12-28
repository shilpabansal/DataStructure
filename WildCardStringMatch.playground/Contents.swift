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
    func isMatch(_ mainString: String, _ pattern: String) -> Bool {
        var matrix = [[Bool]](repeating: [Bool](repeating: false, count: mainString.count + 1), count: pattern.count + 1)
        
        var patternIndex = 0
        while patternIndex <= pattern.count {
            var strIndex = 0
            while strIndex <= mainString.count {
                checkCondition(matrix: &matrix,
                               patternIndex: patternIndex,
                               strIndex: strIndex,
                               pattern: pattern,
                               mainString: mainString)
                strIndex += 1
            }
            if matrix[patternIndex].allSatisfy( { $0 == false }) {
                return false
            }
            patternIndex += 1
        }
        return matrix[pattern.count][mainString.count]
    }
    
    private func checkCondition(matrix: inout [[Bool]],
                                patternIndex: Int,
                                strIndex: Int,
                                pattern: String,
                                mainString: String) {
        print("pattern:\(pattern) patternIndex:\(patternIndex) mainString:\(mainString) strIndex:\(strIndex)")
        if (patternIndex == 0 && strIndex == 0) {
            matrix[0][0] = true
            return
        }
        
        if (strIndex > mainString.count || patternIndex > pattern.count) {
            return
        }
        
        if strIndex == 0 {
            if pattern[patternIndex-1] == "*" {
                matrix[patternIndex][strIndex] = matrix[patternIndex-1][strIndex]
            }
            else {
                matrix[patternIndex][strIndex] = patternIndex == 0
            }
            return
        }
        else if patternIndex == 0 {
            matrix[patternIndex][strIndex] = false
            return
        }
    
        let patternChar = pattern[patternIndex-1]
        let mainStringChar = mainString[strIndex-1]
        
        if patternChar == mainStringChar || patternChar == "?" {
            matrix[patternIndex][strIndex] = matrix[patternIndex-1][strIndex-1]
        }
        else if patternChar == "*" {
            matrix[patternIndex][strIndex] = matrix[patternIndex-1][strIndex] || matrix[patternIndex][strIndex-1]
        }
        else {
            matrix[patternIndex][strIndex] = false
        }
    }
}


let solution = Solution()

let mainString = "baaabaaaabbabbaaaaabbbaaabbaababbaaababbbabbaabaaababbababbaababaaababaababbaabaababaabbbabbabbabbbaababbbbbbaaabababababaababbbaababbbbaaaabaaabbaaababaaaabbbbbbbaabbbbabaabbbabbababbabbaaabbbbaaabbbb"

let pattern = "a**b*bb*babbba**b**a**b**baaa**ababab****a*ab******b*a*bb*b****a*abb*a**a**b**aab****baabb*abaaaabb*" //

let result = solution.isMatch(mainString, pattern)

print("mainString:\(mainString) pattern:\(pattern) result:\(result)")

