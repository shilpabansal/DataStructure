extension String {
    subscript(index: Int) -> String {
        return "\(Array(self)[index])"
    }
    
    func index(of: Int) -> Index {
        return self.index(startIndex, offsetBy: of)
    }
}

class Solution {
    func partition(_ s: String) -> [[String]] {
        var result = [[String]]()
        
        getPartitionArray(s, index: 0, array: [], result: &result)
        return result
    }
    
    private func isPalindrome(_ s: String) -> Bool {
        if s.count == 0 || s.count == 0 {
            return true
        }
        var startIndex = 0
        var endIndex = s.count - 1
        
        while startIndex < endIndex,
              s[startIndex] == s[endIndex] {
            startIndex += 1
            endIndex -= 1
        }
        return startIndex >= endIndex
    }
    
    private func getPartitionArray(_ s: String, index:Int, array: [String], result: inout [[String]]) {
        if s.isEmpty {
            result.append(array)
            return
        }
        if index >= s.count { return }
        let newString = String(s.dropLast(s.count - index - 1))
        
        if isPalindrome(newString) {
            var newArray = array
            newArray.append(newString)
            getPartitionArray(String(s.dropFirst(index+1)), index: 0, array: newArray, result: &result)
        }
        
        getPartitionArray(s, index: index+1, array:array, result: &result)
    }
    
    
}

let str = "a"
let solution = Solution()
print(solution.partition(str))


