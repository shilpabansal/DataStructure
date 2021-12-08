func nQueenProblem() -> [[[String]]] {
    var result = [[[String]]]()
    var board = [[String]](repeating: [String](repeating: "", count: 4), count: 4)
    let Queens = ["Q1", "Q2", "Q3", "Q4"]

    var initialColumn = 0

    while initialColumn < 4 {
        var row = 0
        var column = initialColumn
        while true {
            var areAllRowsEmpty = true
            
            for i in 0..<4 {
                if !board[i][column].isEmpty {
                    areAllRowsEmpty = false
                    break
                }
            }

            var areAllColumnsEmpty = true
            for i in 0..<4 {
                if !board[row][i].isEmpty {
                    areAllColumnsEmpty = false
                    break
                }
            }

            var areAllDiagonalsEmpty = true
            for i in 0..<4 {
                for j in 0..<4 {
                    if abs(row-i) == abs(column-j) && !board[i][j].isEmpty {
                        areAllDiagonalsEmpty = false
                        break
                    }
                }
            }
            
            //If there is no collision fill the cell and increase row index
            if areAllColumnsEmpty && areAllRowsEmpty && areAllDiagonalsEmpty {
                board[row][column] = Queens[row]
                row += 1
                if row == 4 {
                    result.append(board)
                    board = [[String]](repeating: [String](repeating: "", count: 4), count: 4)
                    initialColumn += 1
                    break
                }
                column = 0
                continue
            }
            else {
                column += 1
                if column == 4 {
                    // If the columns are reached till 4 and no cell is filled, start filling the cell from row 0 with updating initial count
                    if areAllColumnsEmpty {
                        board = [[String]](repeating: [String](repeating: "", count: 4), count: 4)
                        initialColumn += 1
                        break
                    }
                    continue
                }
            }
        }
    }
    return result
}

let result = nQueenProblem()
result.forEach { firstResult in
    print(firstResult)
}
