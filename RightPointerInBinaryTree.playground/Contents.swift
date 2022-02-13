public class Node {
    public var val: Int
    public var left: Node?
    public var right: Node?
    public var next: Node?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
        self.next = nil
    }
}

extension Node: CustomStringConvertible {
    public var description: String {
        var result = "\(val) \(next)"
        
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
    func connect(_ root: Node?) -> Node? {
        var head = root
        while head != nil {
            let dummyNode: Node? = Node(0)
            var temp: Node? = dummyNode
            
            while head != nil {
                if head?.left != nil {
                    temp?.next = head?.left
                    temp = temp?.next
                }
                if head?.right != nil {
                    temp?.next = head?.right
                    temp = temp?.next
                }
                
                head = head?.next
            }
            
            head = dummyNode?.next
        }
       
        return root
    }
}

let solution = Solution()
let node1 = Node(1)
let node2 = Node(2)
let node3 = Node(3)
let node4 = Node(4)
let node5 = Node(5)
let node7 = Node(7)

node2.left = node4
node2.right = node5
node3.right = node7
node1.left = node2
node1.right = node3
print(node1)
if let result = solution.connect(node1) {
    print(result)
}
