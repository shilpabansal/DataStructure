/* Incomplete */
class Solution {
    private func recurseAndUpdate(_ board: inout [[Character]], rowIndex: Int, colIndex: Int) {
        if board[rowIndex][colIndex] != "X" {
            board[rowIndex][colIndex] = "1"
            
            if rowIndex-1 >= 0 && board[rowIndex-1][colIndex] != "X" {
                recurseAndUpdate(&board, rowIndex: rowIndex-1, colIndex: colIndex)
            }
            if rowIndex+1 < board.count && board[rowIndex+1][colIndex] != "X" {
                recurseAndUpdate(&board, rowIndex: rowIndex+1, colIndex: colIndex)
            }
            if colIndex-1 >= 0 && board[rowIndex][colIndex-1] != "X" {
                recurseAndUpdate(&board, rowIndex: rowIndex, colIndex: colIndex-1)
            }
            
            if colIndex+1 < board[0].count && board[rowIndex][colIndex+1] != "X" {
                recurseAndUpdate(&board, rowIndex: rowIndex, colIndex: colIndex+1)
            }
        }
        else {
            return
        }
    }
    
    func solve(_ board: inout [[Character]]) {
        print("Input: ")
        if board.count == 1 {
            return
        }
        for rowIndex in 0..<board.count {
            for colIndex in 0..<board[0].count {
                print("\(board[rowIndex][colIndex])", terminator: " ")
            }
            print()
        }
        var rowIndex = 0
        var colIndex = 0
        
        while true {
            recurseAndUpdate(&board, rowIndex: rowIndex, colIndex: colIndex)
            
            if rowIndex == 0 && colIndex + 1 < board[0].count {
                colIndex += 1
            }
            else if colIndex == 0 && rowIndex > 0 {
                rowIndex -= 1
            }
            else if rowIndex == board.count - 1 && rowIndex > 0 {
                colIndex -= 1
            }
            else if colIndex == board[0].count - 1 && rowIndex + 1 < board.count {
                rowIndex += 1
            }
            
            if rowIndex == 0 && colIndex == 0 {
                break
            }
        }
        
        print("converted: ")
        for rowIndex in 0..<board.count {
            for colIndex in 0..<board[0].count {
                print("\(board[rowIndex][colIndex])", terminator: " ")
            }
            print()
        }
        
        for rowIndex in 0..<board.count {
            for colIndex in 0..<board[0].count {
                if board[rowIndex][colIndex] == "O" {
                    board[rowIndex][colIndex] = "X"
                }
                else if board[rowIndex][colIndex] == "1" {
                    board[rowIndex][colIndex] = "O"
                }
            }
        }
        print("Mapped: ")
        for rowIndex in 0..<board.count {
            for colIndex in 0..<board[0].count {
                print("\(board[rowIndex][colIndex])", terminator: " ")
            }
            print()
        }
    }
}

var board: [[Character]] = [["X","X","X","X"],
                            ["X","O","O","X"],
                            ["X","X","O","X"],
                            ["X","O","X","X"]]

/*board = [["O","O"],["O","O"]]
 board = [["X","X","X"],["X","O","X"],["X","X","X"]]*/

board = [["O","X","X","O","X"],
         ["X","O","O","X","O"],
         ["X","O","X","O","X"],
         ["O","X","O","O","O"],
         ["X","X","O","X","O"]]

//board = [["O","X","O"],["X","O","X"],["O","X","O"]]

let solution = Solution()
solution.solve(&board)
print(board)
