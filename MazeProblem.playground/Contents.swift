/*
 Count number of ways to reach destination in a Maze

 Given a maze with obstacles, count the number of paths to reach the rightmost-bottommost cell from the topmost-leftmost cell. A cell in the given maze has a value of -1 if it is a blockage or dead-end, else 0.
 From a given cell, we are allowed to move to cells (i+1, j) and (i, j+1) only.

 Examples:

 Become a success story instead of just reading about them. Prepare for coding interviews at Amazon and other top product-based companies with our Amazon Test Series. Includes topic-wise practice questions on all important DSA topics along with 10 practice contests of 2 hours each. Designed by industry experts that will surely help you practice and sharpen your programming skills. Wait no more, start your preparation today!

 Input: maze[R][C] =  {{0,  0, 0, 0},
                       {0, -1, 0, 0},
                       {-1, 0, 0, 0},
                       {0,  0, 0, 0}};
 Output: 4
 
 {
 {0, 0, 0, _},
 {_, _, 0, _},
 {_, _, 0, _},
 {_, _, 0, 0}
 }
 
 {
 {0, 0, 0, 0},
 {_, _, _, 0},
 {_, _, _, 0},
 {_, _, _, 0}
 }
 
 {
 {0, 0, 0, _},
 {_, _, 0, 0},
 {_, _, _, 0},
 {_, _, _, 0}
 }
 
 {
 {0, 0, 0, _},
 {_, _, 0, _},
 {_, _, 0, 0},
 {_, _, _, 0}
 }
 */

func possiblePathsCount(_ maze: [[Int]])
{
    let NumberOfRows = maze.count
    let NumberOfColumn = maze[0].count
    print("Input maze is")
    for i in 0..<NumberOfRows {
        for j in 0..<NumberOfColumn {
            print(maze[i][j], terminator: (j == NumberOfColumn-1) ? "" : ",")
        }
        print((i == NumberOfRows-1) ? "\n" : "")
    }
    
    var maze = maze
    if (maze[0][0] == -1) {
        print("No possible paths")
        return
    }
        
    /*
     For top most row and left most column, there can be max 1 way to reach, if the value is 0,
     so assign value 1 to it for value == 0, else ignore
     */
    for i in 0..<NumberOfColumn
    {
        if (maze[0][i] == 0) {
            maze[0][i] = 1
        }
        else {
            break
        }
    }
    
    
    for i in 0..<NumberOfRows
    {
        if (maze[i][0] >= 0) {
            maze[i][0] = 1
        }
        else {
            break
        }
    }
    
    // for every index starting from 1, check if j-1 and i-1 are >1 if yes, add and update the value
    for i in 1..<NumberOfRows
    {
        for j in 1..<NumberOfColumn
        {
            // If blockage is found, ignore this cell
            if (maze[i][j] == -1) {
                continue
            }
               
            // If we can reach maze[i][j] from maze[i-1][j]
            // then increment count.
            if (maze[i-1][j] > 0) {
                maze[i][j] = (maze[i][j] + maze[i-1][j])
            }
 
            // If we can reach maze[i][j] from maze[i][j-1]
            // then increment count.
            if (maze[i][j-1] > 0) {
                maze[i][j] = (maze[i][j] + maze[i][j-1])
            }
        }
    }
 
    // If the final cell is blocked, output 0, else the bottom right cell will be the output
    let result = (maze[NumberOfRows-1][NumberOfColumn-1] > 0) ? maze[NumberOfRows-1][NumberOfColumn-1] : 0
    print("Possible paths are \(result)")
}

var maze =  [[0, 0, 0, 0],
             [0, -1, 0, 0],
             [-1, 0, 0, 0],
             [0, 0, 0, 0]]
possiblePathsCount(maze)

