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

extension TreeNode : CustomStringConvertible {
    public var description: String {
        var result = "\(val)"
        if let left = left {
            result += " -> \(left.description)"
        }
        else {
            result += " -> nil"
        }
        if let right = right {
            result += " -> \(right.description)"
        }
        else {
            result += " -> nil"
        }
        return result
    }
}

class Solution {
    func flatten(_ root: TreeNode?) {
        guard let root = root else { return }
        
        let tempLeft = root.left
        let tempRight = root.right
        
        root.left = nil
        flatten(tempLeft)
        flatten(tempRight)
        
        var node: TreeNode? = tempLeft
        while node?.right != nil {
            node = node?.right
        }
        if tempLeft != nil {
            root.right = tempLeft
            node?.right = tempRight
        }
    }
}

let node1 = TreeNode(1, TreeNode(2, TreeNode(3), TreeNode(4)), TreeNode(5, nil, TreeNode(6)))
let node2 = TreeNode(1, TreeNode(2, TreeNode(5), TreeNode(3)), TreeNode(4, nil, TreeNode(6)))
let node3 = TreeNode(-8, TreeNode(-3, TreeNode(-8, nil , TreeNode(-1, nil, TreeNode(8))), nil), TreeNode(0))
let solution = Solution()
solution.flatten(node3)
print(node3)
