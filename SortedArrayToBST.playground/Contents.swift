/* Not completed */
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

public class ListNode: CustomStringConvertible {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) {
        self.val = val
        self.next = next
    }
    
    public var description: String {
        var result = "\(val)"
        if let next = next {
            result += " -> \(next.description)"
        }
        return result
    }
}

class Solution {
    func sortedListToBST(_ head: ListNode?) -> TreeNode? {
        return convertedToBST(head, end: nil)
    }
    
    private func convertedToBST(_ head: ListNode?, end: ListNode?) -> TreeNode? {
        print("head: \(head) end: \(end)")
        if head == nil {
            return nil
        }
        else if (head?.next == nil || head?.val == end?.val), let val = head?.val {
            return TreeNode(val)
        }
        else if head?.next?.val == end?.val,
                let val = head?.val,
                let endValue = end?.val {
            let root = TreeNode(val)
            root.right = TreeNode(endValue)
            return root
        }
        var fastPointer: ListNode? = head
        var slowPointer: ListNode? = head
        var preNode: ListNode?
              
        
        while (end == nil && fastPointer?.next != nil) ||
                (end != nil && fastPointer?.next?.val != end?.val) {
            preNode = slowPointer
            slowPointer = slowPointer?.next
            if fastPointer?.next?.next == nil {
                fastPointer = fastPointer?.next
            }
            else {
                fastPointer = fastPointer?.next?.next
            }
        }
        print("slow:\(slowPointer) fast: \(fastPointer) preNode:\(preNode)")
        if fastPointer?.val == slowPointer?.val,
           let val = preNode?.val,
           let slowVal = slowPointer?.val {
            let root = TreeNode(val)
            root.right = TreeNode(slowVal)
            return root
        }
        else if let val = slowPointer?.val {
            let root = TreeNode(val)
            root.left = convertedToBST(head, end: preNode)
            root.right = convertedToBST(slowPointer?.next, end: fastPointer)
            return root
        }
        return nil
    }
}

let list1 = ListNode(0, ListNode(1, ListNode(2, ListNode(3, ListNode(4, ListNode(5, nil))))))
let list2 = ListNode(-1, ListNode(1, ListNode(0, ListNode(2, nil))))
let list3 = ListNode(3, ListNode(5, ListNode(8, nil)))
let solution = Solution()
if let result = solution.sortedListToBST(list1) {
    print(result)
}
