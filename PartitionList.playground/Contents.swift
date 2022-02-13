public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

extension ListNode: CustomStringConvertible {
    public var description: String {
        var result = ""
        result += "\(val)"
        if let next = next {
            result += " -> \(next.description)"
        }
        return result
    }
}

class Solution {
    func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
        var head = head
        var preNode: ListNode? = nil
        var movingNode: ListNode? = nil
        
        var prePlacingNode: ListNode? = nil
        var placingNode: ListNode? = nil
        
        var didFindNumber = false
        var node = head
        while node != nil {
            if let val = node?.val {
                if val >= x && placingNode == nil {
                    prePlacingNode = preNode
                    placingNode = node
                    didFindNumber = true
                }
                
                if didFindNumber && val < x {
                    movingNode = node
                    
                    preNode?.next = movingNode?.next
                    node = preNode?.next
                    
                    
                    movingNode?.next = placingNode
                    prePlacingNode?.next = movingNode
                    prePlacingNode = prePlacingNode?.next
                    if prePlacingNode == nil {
                        head = movingNode
                        prePlacingNode = movingNode
                    }
                    continue
                }
            }
            
            preNode = node
            node = node?.next
        }
        return head
    }
}

let solution = Solution()
let listNode = ListNode(1, ListNode(4, ListNode(3, ListNode(0, ListNode(5, ListNode(2, nil))))))

//let listNode = ListNode(2, ListNode(1, nil))
print(listNode)
let result = solution.partition(listNode, 2)
print(result)
