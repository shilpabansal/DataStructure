public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

extension ListNode {
    func insert(element: Int) {
        let newNode = ListNode(element, nil)
        if next == nil {
            next = newNode
        }
        else {
            var currentNode = next
            while currentNode?.next != nil {
                currentNode = currentNode?.next
            }
            currentNode?.next = newNode
        }
    }
}

extension ListNode: CustomStringConvertible {
    public var description: String {
        var str = ""
        var currentNode = next
        
        while currentNode != nil {
            if let val = currentNode?.val {
                str += "\(val) -> "
            }
            currentNode = currentNode?.next
        }
       
        return str
    }
}

class Solution {
    func swapPairs(_ head: ListNode?) -> ListNode? {
        var resultNode: ListNode?
        
        var currentNode = head
        while currentNode != nil {
            currentNode = currentNode?.next
            
            if let firstValue = currentNode?.next?.val,
               let secondValue = currentNode?.val {
                let secondNode = ListNode(secondValue, nil)
                let firstNode = ListNode(firstValue, secondNode)
                
                if resultNode == nil {
                    resultNode = head
                    resultNode?.next = firstNode
                }
                else {
                    var resultCurrentNode = resultNode
                    while resultCurrentNode?.next != nil {
                        resultCurrentNode = resultCurrentNode?.next
                    }
                    resultCurrentNode?.next = firstNode
                }
            }
            currentNode = currentNode?.next
            
        }
        return resultNode
    }
}

let node = ListNode()
node.insert(element: 1)
node.insert(element: 2)
node.insert(element: 3)
node.insert(element: 4)
print("Input: \(node)")

let solution = Solution()
if let result = solution.swapPairs(node) {
    print(result)
}

