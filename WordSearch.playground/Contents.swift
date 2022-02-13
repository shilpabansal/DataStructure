/* Not completed */
extension String {
    func containsString(_ str: String) -> Bool {
        var index = 0
        if str.isEmpty { return true }
        while index < self.count {
            if self[index] == str[0] {
                let startIndex = index
                
                var newIndex = 0
                while newIndex < str.count {
                    if startIndex + newIndex >= self.count ||
                        self[startIndex + newIndex] != str[newIndex] {
                        break
                    }
                    newIndex += 1
                }
                if newIndex == str.count {
                    return true
                }
            }
            index += 1
        }
        return false
    }
    
    func index(of: Int) -> Index {
        return self.index(startIndex, offsetBy: of)
    }
    
    subscript(index: Int) -> Character {
        return Array(self)[index]
    }
}

class Solution {
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        
        for char in word {
            var doesExists = false
            for row in 0..<board.count {
                let str = String(board[row])
                if str.contains(char) {
                    doesExists = true
                    break
                }
            }
            if !doesExists {
                return false
            }
        }
        
        var result = false
        for row in 0..<board.count {
            for column in 0..<board[0].count {
                var canBeVisited = canVisit(board, word)
                if word[0] == board[row][column] {
                    wordSearch(board, word, "", rowIndex: row, colIndex: column, canBeVisited: &canBeVisited, result: &result)
                }
            }
        }
        return result
    }
    
    func wordSearch(_ board: [[Character]], _ word: String, _ newWord: String, rowIndex: Int, colIndex: Int, canBeVisited: inout [[Bool]], result: inout Bool) {
        if rowIndex < 0 || rowIndex >= board.count ||
            colIndex < 0 || colIndex >= board[0].count ||
            !canBeVisited[rowIndex][colIndex]
        {
            return
        }
        
        let newWord = newWord + "\(board[rowIndex][colIndex])"
        
        if newWord == word {
            result = true
            return
        }
        if !word.containsString(newWord) {
            return
        }
        canBeVisited[rowIndex][colIndex] = false
        
        wordSearch(board, word, newWord, rowIndex: rowIndex + 1, colIndex: colIndex, canBeVisited: &canBeVisited, result: &result)
        wordSearch(board, word, newWord, rowIndex: rowIndex - 1, colIndex: colIndex, canBeVisited: &canBeVisited, result: &result)
        wordSearch(board, word, newWord, rowIndex: rowIndex, colIndex: colIndex + 1, canBeVisited: &canBeVisited, result: &result)
        wordSearch(board, word, newWord, rowIndex: rowIndex, colIndex: colIndex - 1, canBeVisited: &canBeVisited, result: &result)
        
        return
    }
    
    private func canVisit(_ board: [[Character]], _ word: String) -> [[Bool]] {
        var canBeVisited = [[Bool]](repeating: [Bool](repeating: true, count: board[0].count), count: board.count)
        for row in 0..<board.count {
            for column in 0..<board[0].count {
                if !word.contains(board[row][column]) {
                    canBeVisited[row][column] = false
                }
            }
        }
        return canBeVisited
    }
}

let board: [[Character]] = [["A","A","A","A","A","A"],
                            ["A","A","A","A","A","A"],
                            ["A","A","A","A","A","A"],
                            ["A","A","A","A","A","A"],
                            ["A","A","A","A","A","B"],
                            ["A","A","A","A","B","A"]]
let word = "AAAAAAAAAAAAABAB"
let solution = Solution()
print(solution.exist(board, word))
