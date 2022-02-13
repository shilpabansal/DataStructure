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
    private var lastNode = TreeNode(Int.min)
    func isValidBST(_ root: TreeNode?) -> Bool {
        guard let root = root else { return true }
        
        if !isValidBST(root.left) {
            return false
        }
        
        if root.val <= lastNode.val {
            return false
        }
        lastNode = root
        
        return isValidBST(root.right)
    }
}

let solution = Solution()
let treeNode = TreeNode(2, TreeNode(1), TreeNode(3))
print(solution.isValidBST(treeNode))
