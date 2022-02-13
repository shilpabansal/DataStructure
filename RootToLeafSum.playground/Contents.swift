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
    func sumNumbers(_ root: TreeNode?) -> Int {
        var totalSum = 0
        calculateSum(root, lastSum: 0, totalSum: &totalSum)
        return totalSum
    }
    
    private func calculateSum(_ root: TreeNode?, lastSum: Int, totalSum: inout Int) {
        guard let root = root else { return }
        
        let sum = lastSum * 10 + root.val
        if root.left == nil && root.right == nil {
            print("sum: \(sum)")
            totalSum += sum
        }
       
        calculateSum(root.left, lastSum: sum, totalSum: &totalSum)
        
        calculateSum(root.right, lastSum: sum, totalSum: &totalSum)
    }
}

let solution = Solution()
let node = TreeNode(4, TreeNode(9, TreeNode(5), TreeNode(1)), TreeNode(0))
print(solution.sumNumbers(node))
