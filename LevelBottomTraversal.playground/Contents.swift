import Foundation
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

class Solution {
    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        var result = [[Int]]()
        getArray(root, result: &result, currentLevel: 0)
        
        for (index, elment) in result.enumerated() {
            if index % 2 != 0 {
                result[index] = elment.reversed()
            }
        }
        return result
    }
    
    func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
        var result = [[Int]]()
        getArray(root, result: &result, currentLevel: 0)
        return result.reversed()
    }
    
    private func getArray(_ root: TreeNode?, result: inout [[Int]], currentLevel: Int) {
        if root == nil {
            return
        }
        if let val = root?.val {
            if currentLevel < result.count {
                result[currentLevel].append(val)
            }
            else {
                result.append([val])
            }
        }
        
        getArray(root?.left, result: &result, currentLevel: currentLevel + 1)
        getArray(root?.right, result: &result, currentLevel: currentLevel + 1)
    }
}

let node1 = TreeNode(3, TreeNode(9), TreeNode(20, TreeNode(15), TreeNode(7)))
let node2 = TreeNode(1)
let node3 = TreeNode(1, TreeNode(2, TreeNode(4), nil), TreeNode(3, nil, TreeNode(5)))
let solution = Solution()
print("Level order: \(solution.levelOrderBottom(node1))")
print("Zigzag order: \(solution.zigzagLevelOrder(node1))")
