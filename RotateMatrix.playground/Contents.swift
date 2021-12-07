//Rotate a matrix by 90 degree anti clock wise without using extra space

var matrix = [[1, 2, 3, 4],
              [5, 6, 7, 8],
              [9, 10, 11, 12],
              [13, 14, 15, 16]]
print("Input matrix: \(matrix)")

let orderOfMatrix = 4
/* Reverse matrix: Reverse the element of each row
 1, 2, 3, 4 should be reversed to 4, 3, 2, 1
 */
for i in 0..<orderOfMatrix {
    for j in 0..<orderOfMatrix {
        let temp =  matrix[i][j]
        matrix[i][j] = matrix[i][orderOfMatrix-j-1]
        matrix[i][orderOfMatrix-j-1] = temp
        
        if j == orderOfMatrix/2 - 1 {
            break
        }
     }
}
print("Reversed matrix: \(matrix)")


/*Transpose matrix: Row and columns should be replaced
 1, 2, 3
 4, 5, 6
 7, 8, 9
 should be changed to
 1, 4 ,7
 2, 5, 8
 3, 6, 9
 */
for i in 0..<orderOfMatrix {
    for j in i..<orderOfMatrix {
        let temp =  matrix[i][j]
        matrix[i][j] = matrix[j][i]
        matrix[j][i] = temp
     }
}

print("Anti clock wise rotated matrix: \(matrix)")
/*
 The result is
    [[4, 8, 12, 16],
    [3, 7, 11, 15],
    [2, 6, 10, 14],
    [1, 5, 9, 13]]
*/



//Rotate clock wise
matrix = [[1, 2, 3, 4],
          [5, 6, 7, 8],
          [9, 10, 11, 12],
          [13, 14, 15, 16]]
print("\n Input matrix for clock wise rotation: \(matrix)")

for i in 0..<orderOfMatrix {
    for j in i..<orderOfMatrix {
        let temp =  matrix[i][j]
        matrix[i][j] = matrix[j][i]
        matrix[j][i] = temp
     }
}
print("transposed matrix: \(matrix)")

for i in 0..<orderOfMatrix {
    for j in 0..<orderOfMatrix {
        let temp =  matrix[i][j]
        matrix[i][j] = matrix[i][orderOfMatrix-j-1]
        matrix[i][orderOfMatrix-j-1] = temp
        
        if j == orderOfMatrix/2 - 1 {
            break
        }
     }
}
print("Clock wise rotated matrix: \(matrix)")
