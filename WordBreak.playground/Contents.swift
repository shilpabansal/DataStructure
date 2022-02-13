extension String {
    subscript(forIndex: Int) -> Character {
        return Array(self)[forIndex]
    }
}

class Solution {
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        return breakWords(s, index: 0, array: [], wordDict: wordDict)
    }
    
    private func breakWords(_ s: String, index: Int, array: [String], wordDict: [String]) -> Bool {
        print("s: \(s) index: \(index)")
        if s.isEmpty {
            return true
        }
        
        if index >= s.count {
            return wordDict.contains(s)
        }
        let newString = String(s.dropLast(s.count - index - 1))
        
        if wordDict.contains(newString) {
            var newArray = array
            if !newArray.contains(newString) {
                newArray.append(newString)
            }
            print("newArray: \(newArray) nextArary: \(String(s.dropFirst(index+1)))")
            return breakWords(String(s.dropFirst(index+1)), index: 0, array: newArray, wordDict: wordDict)
        }
        
        return breakWords(s, index: index+1, array:array, wordDict: wordDict)
    }
}

let solution = Solution()
//let s = "applepenapple", wordDict = ["apple","pen"]
//let s = "bb", wordDict = ["a","b","bbb","bbbb"]
//let s = "catsandog", wordDict = ["cats","dog","sand","and","cat"]
let s = "aaaaaaa", wordDict = ["aaaa","aaa"]
print(solution.wordBreak(s, wordDict))
