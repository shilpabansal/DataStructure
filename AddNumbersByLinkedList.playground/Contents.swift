/**
 * Definition for singly-linked list.*/
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
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var result: ListNode? = nil
        var pointer1: ListNode? = l1
        var pointer2: ListNode? = l2
        
        var carry = 0
        var addition = 0
        var node: ListNode?
        while pointer1 != nil ||
              pointer2 != nil ||
              carry != 0 {
            addition = (pointer1?.val ?? 0) + (pointer2?.val ?? 0) + carry
            carry = addition >= 10 ? 1 : 0
            addition = addition >= 10 ? addition - 10: addition
            
            if result == nil {
                result = ListNode(addition, nil)
                node = result
            }
            else {
                node?.next = ListNode(addition, nil)
                node = node?.next
            }
            pointer1 = pointer1?.next
            pointer2 = pointer2?.next
        }
        return result
    }
}

let solution = Solution()
let l3 = ListNode(3, nil)
let l4 = ListNode(4, l3)
let l2 = ListNode(2, l4)

let l42 = ListNode(4, nil)
let l6 = ListNode(6, l42)
let l5 = ListNode(5, l6)

print(l2)
print(l5)
if let result1 = solution.addTwoNumbers(l2, l5) {
    print(result1)
}

