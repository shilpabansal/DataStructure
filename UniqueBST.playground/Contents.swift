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
    func numTrees(_ n: Int) -> Int {
        guard n > 1 else { return 1 }
        
        var arr: [Int] = .init(repeating: 0, count: n + 1)
        arr[0] = 1; arr[1] = 1
        
        for i in 2...n where n >= 2 {
            for j in 0..<i {
                arr[i] += arr[j] * arr[i - 1 - j]
            }
        }
        return arr[n]
    }
    
    func generateTrees(_ n: Int) -> [TreeNode?] {
        return genTrees(start: 1, end: n)
    }
    
    private func genTrees (start: Int, end: Int) -> [TreeNode?] {
        var result: [TreeNode?] = []
        
        if start > end {
            result.append(nil)
            return result
        }
        else if start == end {
            result.append(TreeNode(start))
            return result
        }
        
        for i in start ... end {
            let left = genTrees(start: start, end: i - 1)
            let right = genTrees(start: i + 1, end: end)
            for left_node in left {
                for right_node in right {
                    let root = TreeNode(i, left_node, right_node)
                    result.append(root)
                }
            }
        }
        return result
    }
}

let solution = Solution()
let result = solution.generateTrees(3)
for element in result {
    if let element = element {
        print(element)
    }
}

print(solution.numTrees(5))
