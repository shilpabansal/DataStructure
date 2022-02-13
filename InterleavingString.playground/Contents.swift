extension String {
    subscript(index: Int) -> Character {
        return Array(self)[index]
    }
    
    func index(of: Int) -> Index {
        return self.index(startIndex, offsetBy: of)
    }
}

class Solution {
    func isInterleave(_ s1: String, _ s2: String, _ s3: String) -> Bool {
        if s1.count + s2.count != s3.count {
            return false
        }
        if s1.isEmpty && s2.isEmpty && s3.isEmpty {
            return true
        }
        if s1.isEmpty || s2.isEmpty {
            return (s1.isEmpty && s2 == s3) || (s2.isEmpty && s1 == s3)
        }
        var validString: [[String]] = [[String]](repeating: [String](repeating: "", count: s1.count+1), count: s2.count+1)
        
        
        for rowIndex in 0...s2.count {
            for colIndex in 0...s1.count {
                if rowIndex == 1 && colIndex == 0 {
                    if s3.hasPrefix("\(s2[0])") {
                        validString[rowIndex][colIndex] = "\(s2[0])"
                        continue
                    }
                }
                if colIndex == 1 && rowIndex == 0 {
                    if s3.hasPrefix("\(s1[0])") {
                        validString[rowIndex][colIndex] = "\(s1[0])"
                        continue
                    }
                }
                if rowIndex != 0 && !validString[rowIndex-1][colIndex].isEmpty {
                    let str = "\(validString[rowIndex-1][colIndex])\(s2[rowIndex-1])"
                    if s3.hasPrefix(str) {
                        validString[rowIndex][colIndex] = str
                    }
                }
                
                if colIndex != 0 && !validString[rowIndex][colIndex-1].isEmpty {
                    let str = "\(validString[rowIndex][colIndex-1])\(s1[colIndex-1])"
                    if s3.hasPrefix(str) {
                        validString[rowIndex][colIndex] = str
                    }
                }
            }
        }
       
        for rowIndex in 0...s2.count {
            for colIndex in 0...s1.count {
                print("\(rowIndex):\(colIndex) \(validString[rowIndex][colIndex])", terminator: "        ")
            }
            print("\n")
        }
        return validString[s2.count][s1.count] == s3
    }
}

let s1 = "a"
let s2 = "b"
let s3 = "ab"
let solution = Solution()
print(solution.isInterleave(s1, s2, s3))
