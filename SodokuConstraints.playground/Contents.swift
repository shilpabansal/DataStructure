import UIKit

class Sudoku {
    var sudokuArray = Array(repeating: Array(repeating: 0, count: 9), count: 9)
    let sumOfEachRow = 45
    init() {
        sudokuArray[0][1] = 7
        sudokuArray[0][3] = 2
        sudokuArray[0][4] = 5
        sudokuArray[0][6] = 4
        
        sudokuArray[1][0] = 8
        sudokuArray[1][6] = 9
        sudokuArray[1][8] = 3
        
        sudokuArray[2][5] = 3
        sudokuArray[2][7] = 7
        
        sudokuArray[3][0] = 7
        sudokuArray[3][5] = 4
        sudokuArray[3][7] = 2
        
        sudokuArray[4][0] = 1
        sudokuArray[4][8] = 7
        
        sudokuArray[5][1] = 4
        sudokuArray[5][3] = 5
        sudokuArray[5][8] = 8
        
        sudokuArray[6][1] = 9
        sudokuArray[6][3] = 6
        
        sudokuArray[7][0] = 4
        sudokuArray[7][2] = 1
        sudokuArray[7][8] = 5
        
        sudokuArray[8][2] = 7
        sudokuArray[8][4] = 8
        sudokuArray[8][5] = 2
        sudokuArray[8][7] = 3
    }
    
    func getLowestAndHighestIndex(forNo: Int) -> (Int, Int) {
        if forNo >= 0 && forNo <= 2 {
            return (0, 2)
        }
        else if forNo >= 3 && forNo <= 5 {
            return (3, 5)
        }
        else {
            return (6, 8)
        }
    }
    
    func isBreakingConstraint(no: Int, rowIndex: Int, colIndex: Int) -> Bool {
        //row and column Constraint
        for i in 0...8 {
            if sudokuArray[rowIndex][i] == no && i != colIndex {
                return true
            }
        }
        
        for i in 0...8 {
            if sudokuArray[i][colIndex] == no && i != rowIndex {
                return true
            }
        }
        
        let (lowestRow, highestRow) = getLowestAndHighestIndex(forNo: rowIndex)
        let (lowestCol, highestCol) = getLowestAndHighestIndex(forNo: colIndex)
        //cube constraint
        for i in lowestRow...highestRow {
            for j in lowestCol...highestCol {
                if sudokuArray[i][j] == no {
                    return true
                }
            }
        }
        
        return false
    }
    
    func printNumbers() {
        for i in 0...8 {
            for j in 0...8 {
                print(sudokuArray[i][j], terminator: "  ")
            }
            print("\n")
        }
    }
    
    func fillNumbers(startingNo : Int? = 0) {
        for fillingNo in 1...9 {
            for i in 0...8 {
                for j in 0...8 {
                    if !isBreakingConstraint(no: fillingNo, rowIndex: i, colIndex: j) && sudokuArray[i][j] == 0 {
                        sudokuArray[i][j] = fillingNo
                    }
                }
            }
        }
        print("Sudoku Result")
        sudoku.printNumbers()
        testCompletedSudoku() ? print("Sudoku result is correct") : print("Sudoku result is incorrect")
    }
    
    func testCompletedSudoku() -> Bool {
        for i in 0...8 {
            var sumOfEachRow = 0
            for j in 0...8 {
                sumOfEachRow += sudokuArray[i][j]
            }
            if sumOfEachRow != 45 {
                return false
            }
        }
        
        for i in 0...8 {
            var sumOfEachColumn = 0
            for j in 0...8 {
                sumOfEachColumn += sudokuArray[j][i]
            }
            if sumOfEachColumn != 45 {
                return false
            }
        }
        return true
    }
}

let sudoku = Sudoku()
print("Initial sudoku")
sudoku.printNumbers()
sudoku.fillNumbers()
