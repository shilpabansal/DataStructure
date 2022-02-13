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
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        if inorder.isEmpty { return nil }
       
        if inorder.count == 1 { return TreeNode(inorder[0])}
        
        let index = 0
                
        let root = TreeNode(preorder[index])
        if let inorderIndex = inorder.enumerated().first(where: { $0.1 == preorder[index] })?.0 {
            root.left = buildTree(Array(preorder[1..<preorder.count]), Array(inorder[index..<inorderIndex]))
            root.right = buildTree(Array(preorder[inorderIndex+1..<preorder.count]), Array(inorder[inorderIndex+1..<inorder.count]))
        }
        return root
    }
    
    func buildTreeFromPostOrder(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        print("inorder: \(inorder) postorder:\(postorder)")
        if inorder.isEmpty { return nil }
        if inorder.count == 1 { return TreeNode(inorder[0]) }
        
        let index = postorder.count - 1
        let root = TreeNode(postorder[index])
        
        if let inorderIndex = inorder.enumerated().first(where: { $0.1 == postorder[index] })?.0 {
            root.left = buildTreeFromPostOrder(Array(inorder[0..<inorderIndex]), Array(postorder[0..<inorderIndex]))
            
            if inorderIndex < inorder.count {
                let postUpdatedArray = Array(postorder[inorderIndex..<postorder.count-1])
                root.right = buildTreeFromPostOrder(Array(inorder[inorderIndex+1..<inorder.count]), postUpdatedArray)
            }
        }
        return root
    }
}

let solution = Solution()
let preOrder1 = [3, 9, 20, 15, 7]
let inorder1 = [9, 3, 15, 20, 7]

let preOrder = [3, 9, 5, 6, 20, 5, 7]
let inorder = [5, 9, 6, 3, 5, 20, 7]
if let result = solution.buildTree(preOrder, inorder) {
    print(result)
}


let inorder3 = [9, 3, 15, 20, 7]
let postorder3 = [9, 15, 7, 20, 3]

let inorder2 = [1, 2, 3, 4]
let postorder2 = [2, 1, 4, 3]
if let result = solution.buildTreeFromPostOrder(inorder2, postorder2) {
    print(result)
}
