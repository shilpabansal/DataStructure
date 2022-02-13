public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}
 
extension ListNode: CustomStringConvertible {
    public var description: String {
        var result = "\(val)"
        if let next = next {
            result += " -> \(next.description)"
        }
        return result
    }
}

class Solution {
    func reverseBetween(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
        if left >= right {
            return head
        }
        var head = head
        var node = head
        var newNode: ListNode? = nil
        var newHead: ListNode? = nil
        var preNode:ListNode? = nil
        
        var nodeStart: ListNode? = nil
        var nodeEnd: ListNode? = nil
        
        var didFindStart = false
        var index = 1
        
        while node != nil {
            if !didFindStart,
                index == left {
                nodeStart = preNode
                didFindStart = true
            }
            
            if didFindStart,
                let val = node?.val {
                if newHead == nil {
                    newHead = ListNode(val, nil)
                    newNode = newHead
                }
                else {
                    newNode?.next =  ListNode(val, nil)
                    newNode = newNode?.next
                }
            }

            if index == right {
               nodeEnd = node?.next
               break
            }
            preNode = node
            node = node?.next
            index += 1
        }
        
        if !didFindStart {
            return head
        }
        
        newHead = reverse(newHead)
        if nodeStart == nil {
            nodeStart = newHead
            head = newHead
        }
        else {
            nodeStart?.next = newHead
        }
        
        newNode = newHead
        while newNode != nil {
            if newNode?.next == nil {
                break
            }
            newNode = newNode?.next
        }
        newNode?.next = nodeEnd
        return head
    }
    
    func reverse(_ head: ListNode?) -> ListNode? {
        var node = head
        var preNode: ListNode? = nil
        var resultNode: ListNode? = nil
        while node != nil {
            let nextNode = node?.next
            if nextNode == nil {
                resultNode = node
            }
            node?.next = preNode
            preNode = node
            node = nextNode
        }
        return resultNode
    }
}

var node = ListNode(1, ListNode(2, ListNode(3, ListNode(4, ListNode(5, nil)))))
//var node = ListNode(3, ListNode(5, nil))
print("Input: \(node)")
let solution = Solution()
//if let reversedHead = solution.reverse(node) {
//    print("Reversed: \(reversedHead)")
//    node = reversedHead
//}

if let reversedNodes = solution.reverseBetween(node, 2, 4) {
    print("Reversed between 2 & 4: \(reversedNodes)")
}
