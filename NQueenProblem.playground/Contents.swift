extension String {
    func index(to: Int) -> Index {
        return index(startIndex, offsetBy: to)
    }
    
    func subString(from: Int) -> String {
        let fromIndex = index(to: from)
        return String(self[fromIndex...endIndex])
    }
    
    func subString(to: Int) -> String {
        let toIndex = index(to: to)
        return String(self[startIndex...toIndex])
    }
    
    func subString(from: Int, to: Int) -> String {
        let fromIndex = index(to: from)
        let toIndex = index(to: to)
        
        return String(self[fromIndex...toIndex])
    }
    
    subscript(ofIndex: Int) -> String {
        get {
            return self.subString(from: ofIndex, to: ofIndex)
        }
        
        set(newValue) {
            let fromIndex = index(to: ofIndex)
            let toIndex = index(to: ofIndex)
            
            self.replaceSubrange(fromIndex...toIndex, with: newValue)
        }
    }
    
    func intValue(to index: Index) -> Int { distance(from: startIndex, to: index) }
}

class Solution {
    private func isQueenPlaced(_ str: String) -> Bool {
        let doesQueenExist = str.allSatisfy( { $0 != "."} )
        return doesQueenExist
    }
    
    private func areAllRowsEmpty(_ dimen: Int, in board: [String], till column: Int) -> Bool {
        var rowsEmpty = true
        for i in 0..<dimen {
            if isQueenPlaced(board[i][column]) {
                rowsEmpty = false
                break
            }
        }
        return rowsEmpty
    }
    
    private func areAllColumnsEmpty(_ dimen: Int, in board: [String], till row: Int) -> Bool {
        return !isQueenPlaced(board[row])
    }
    
    private func areAllDiagonalsEmpty(_ dimen: Int, in board: [String], row: Int, column: Int) -> Bool {
        var diagonalsEmpty = true
        for i in 0..<dimen {
            for j in 0..<dimen {
                if abs(row-i) == abs(column-j) && isQueenPlaced(board[i][j]) {
                    diagonalsEmpty = false
                    break
                }
            }
        }
        return diagonalsEmpty
    }
    
    private func emptyRow(_ n: Int) -> String {
        var boardRow = ""
        for _ in 0..<n {
            boardRow += "."
        }
        return boardRow
    }
    
    func solveNQueens(_ n: Int) -> [[String]] {
        var result = [[String]]()
        let board = [String](repeating: emptyRow(n), count: n)
        
        if n == 1 { return [["Q"]] }
        print("board:\(board) initialColumn:\(initialColumn) row:\(row) column:\(column)")
        solution(n, initialColumn: n, row: 0, column: 0, board: board, result: &result)
        
        return result
    }
        
    private func solution(_ n: Int, initialColumn: Int, row: Int, column: Int, board: [String], result: inout [[String]]) {
        print("board:\(board) initialColumn:\(initialColumn) row:\(row) column:\(column)")
        if initialColumn > n { return }
        if row == n {
            //If all queens are placed in matrix, add it in result
            if board.allSatisfy( { !isQueenPlaced($0) } ),
               !result.contains(board) {
                result.append(board)
                print("result:\(result)")
            }
            return
        }
        
        //If column index reached till end, start it from zero
        let column = column == n ? 0 : column
        
        if column == initialColumn {
            return
        }
        
        if row < n {
            let rowsEmpty = areAllRowsEmpty(n, in: board, till: column)
            let columnsEmpty = areAllColumnsEmpty(n, in: board, till: row)
            let diagonalsEmpty = areAllDiagonalsEmpty(n, in: board, row: row, column: column)
            
            if columnsEmpty && rowsEmpty && diagonalsEmpty {
                var newBoard = board
                newBoard[row][column] = "Q"
                
                //Once an quuen is placed, increase the row and column index and try for next queen
                solution(n, initialColumn:column, row: row+1, column: column+1, board: newBoard, result: &result)
                
                
                //As initial count is n for row 0, if index reaches back to n, we have travered the whole matrix, there are no solutions left
                if row == 0 && initialColumn+1 == n {
                    return
                }
                
                //As we need to place the queen in all possible columns in each row, once we reach to end of the column, we need to re-initialise it
                let newColumnIndex = initialColumn+1 >= n ? 0 : initialColumn+1
                solution(n, initialColumn: newColumnIndex, row: row, column: column+1, board: board, result: &result)
            }
            else {
                //If there is an element with conflict, increase the column index and check
                solution(n, initialColumn: initialColumn, row: row, column: column+1, board: board, result: &result)
            }
        }
    }
}

let solution = Solution()
let result = solution.solveNQueens(9)
print(result)
