class Solution {
    func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
        let rowCount = obstacleGrid.count
        let columnCount = obstacleGrid[0].count
        if rowCount == 1 && columnCount == 1 {
            return obstacleGrid[0][0] == 1 ? 0 : 1
        }
        
        
        let INT_MAX = 10000
        var matrix = obstacleGrid
        if rowCount == 1 && columnCount == 1 {
            return matrix[0][0] == 1 ? 0 : 1
        }
        
        for rowIndex in 0..<rowCount {
            for colIndex in 0..<columnCount {
                if matrix[rowIndex][colIndex] == 1 {
                    matrix[rowIndex][colIndex] = INT_MAX
                }
            }
        }
        
        var obstacleFound = matrix[0][0] == INT_MAX ? true : false
        for rowIndex in 1..<rowCount {
            if matrix[rowIndex][0] == INT_MAX {
                obstacleFound = true
                continue
            }
            if !obstacleFound {
                matrix[rowIndex][0] = 1
            }
            else {
                matrix[rowIndex][0] = 0
            }
        }
        
        obstacleFound = matrix[0][0] == INT_MAX ? true : false
        for columnIndex in 1..<columnCount {
            if matrix[0][columnIndex] == INT_MAX {
                obstacleFound = true
                continue
            }
            if !obstacleFound {
                matrix[0][columnIndex] = 1
            }
            else {
                matrix[0][columnIndex] = 0
            }
        }
        
        for rowIndex in 1..<rowCount {
            for colIndex in 1..<columnCount {
                if matrix[rowIndex][colIndex] == INT_MAX {
                    continue
                }
                
                switch (matrix[rowIndex-1][colIndex], matrix[rowIndex][colIndex-1]) {
                case (INT_MAX, INT_MAX):
                    matrix[rowIndex][colIndex] = 0
                case (INT_MAX, _):
                    matrix[rowIndex][colIndex] = matrix[rowIndex][colIndex-1]
                case (_, INT_MAX):
                    matrix[rowIndex][colIndex] = matrix[rowIndex-1][colIndex]
                default:
                    matrix[rowIndex][colIndex] = matrix[rowIndex-1][colIndex] + matrix[rowIndex][colIndex-1]
                }
            }
        }
        
        return matrix[rowCount-1][columnCount-1] == INT_MAX ? 0 : matrix[rowCount-1][columnCount-1]
    }
}

let solution = Solution()
let input = [[0,0,0],[0,1,0],[0,0,0]]
print(solution.uniquePathsWithObstacles(input))
