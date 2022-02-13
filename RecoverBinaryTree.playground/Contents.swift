/*
 Inorder tranversal for BST always returns a sorted list, we can create a sorted list from BST and wherever the elements are not in sorted order, they need to be interchanged
 One solution can be to create inorder array, get the 2 nodes where the elements are in decreasing order, get the node by comparing the elememts with node value and inter changes them
 
 The solution implemented here is:
 save the last traversed node with inorder traversal
 compare the current element with last element, if its lesser we update the first node. if we get the second node with element lesser than previous, we update the second node
 and interchange the values
 */
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

extension TreeNode: CustomStringConvertible {
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
    var firstNode: TreeNode?
    var secondNode: TreeNode?
    var previous = TreeNode(Int.min)
    
    func recoverTree(_ root: TreeNode?) {
        inorder(root)
        
        if let firstNode = firstNode,
           let secondNode = secondNode {
            let tempValue = firstNode.val
            firstNode.val = secondNode.val
            secondNode.val = tempValue
        }
    }
    
    private func inorder(_ root: TreeNode?) {
        guard let root = root else { return }
        
        inorder(root.left)
        
        if firstNode == nil && previous.val > root.val {
            firstNode = previous
        }
        
        if firstNode != nil && previous.val > root.val {
            secondNode = root
        }
        previous = root
        inorder(root.right)
    }
}

let solution = Solution()
let treeNode1 = TreeNode(1, TreeNode(3, nil, TreeNode(2)), nil)
let treeNode = TreeNode(3, TreeNode(1), TreeNode(4, TreeNode(2), nil))
print("Input:\(treeNode)")
solution.recoverTree(treeNode)
print(treeNode)
