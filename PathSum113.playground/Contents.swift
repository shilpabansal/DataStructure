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
        if let right = right {
            result += " -> \(right.description)"
        }
        return result
    }
}

class Solution {
    func pathSum(_ root: TreeNode?, _ targetSum: Int) -> [[Int]] {
        var result = [[Int]]()
        
//      getSumByQueue(root, targetSum, result: &result)
        sumByRecursion(root, targetSum, array: [], result: &result)
        return result
    }
    
    private func sumByRecursion(_ root: TreeNode?, _ targetSum: Int, array: [Int], result: inout [[Int]]) {
        guard let root = root else { return }
        if root.left == nil && root.right == nil {
            let sum = array.reduce(0, { $0 + $1 }) + root.val
            if sum == targetSum {
                var array = array
                array.append(root.val)
                result.append(array)
            }
            return
        }
        
        var array = array
        array.append(root.val)
        sumByRecursion(root.left, targetSum, array: array, result: &result)
        sumByRecursion(root.right, targetSum, array: array, result: &result)
    }
    
    private func getSumByQueue(_ root: TreeNode?, _ targetSum: Int, result: inout [[Int]]) {
        var queue = [TreeNode]()
        var arrayQueue = [[Int]]()
        
        var node = root
        
        if let node = node {
            queue.append(node)
            arrayQueue.append([node.val])
            
            if node.left == nil && node.right == nil && node.val == targetSum {
                result = arrayQueue
                return
            }
        }
        else {
            return
        }
        while !queue.isEmpty && !arrayQueue.isEmpty  {
            node = queue.removeFirst()
            let array = arrayQueue.removeFirst()
            if let left = node?.left {
                var leftArray = array
                leftArray.append(left.val)
                
                if left.left == nil && left.right == nil {
                    let sum = leftArray.reduce(0, { $0 + $1 })
                    if sum == targetSum {
                        result.append(leftArray)
                    }
                }
                else {
                    queue.append(left)
                    arrayQueue.append(leftArray)
                }
            }
            
            if let right = node?.right {
                var rightArray = array
                rightArray.append(right.val)
                
                if right.left == nil && right.right == nil {
                    let sum = rightArray.reduce(0, { $0 + $1 })
                    if sum == targetSum {
                        result.append(rightArray)
                    }
                }
                else {
                    queue.append(right)
                    arrayQueue.append(rightArray)
                }
            }
        }
    }
}

let solution = Solution()
let node13 = TreeNode(13, nil, nil)
let node4 = TreeNode(4, TreeNode(5, nil, nil), TreeNode(1, nil, nil))
let node8 = TreeNode(8, node13, node4)

let node11 = TreeNode(11, TreeNode(7, nil, nil), TreeNode(2, nil, nil))
let node4Parent = TreeNode(4, node11, nil)

let node5 = TreeNode(5, node4Parent, node8)

print(solution.pathSum(node5, 22))
