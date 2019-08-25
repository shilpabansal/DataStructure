import UIKit

class Node<T> where T : Equatable {
    var next : Node?
    var data : T
    
    init(_ value: T, next: Node? = nil) {
        self.next = next
        self.data = value
    }
}

extension Node : CustomStringConvertible {
    var description: String {
        if let next = next {
            return "\(data) -> "  + String(describing: "\(next)")
        }
        return "\(data)"
    }
}

let node1 = Node(5)
let node2 = Node(1, next: node1)
let node3 = Node(7, next: node2)


class LinkedList<T> where T : Equatable {
    var head: Node<T>?
    
    //append at end
    func append(_ value: T) {
        let insertingNode = Node(value)
        if head == nil {
            head = insertingNode
        }
        else {
            var nextNode = head
            while nextNode?.next != nil {
                nextNode = nextNode?.next
            }
            nextNode?.next = insertingNode
        }
    }
    
    //append at start
    func push(_ value: T) {
        let insertingNode = Node(value)
        if head == nil {
            head = insertingNode
        }
        else {
            insertingNode.next = head
            head = insertingNode
        }
    }
    
    //Insert some node with value at given location
    func insertAt(_ index: Int, _ value: T) -> Bool {
        var i = 0
        let insertingNode = Node(value)
        if head == nil {
            return false
        }
        else {
            var currentNode = head
            var nextNode = head
            while nextNode != nil {
                if i == index {
                    break
                }
                i = i+1
                currentNode = nextNode
                nextNode = nextNode?.next
            }
            insertingNode.next = nextNode
            
            if i == 0 {
                head = insertingNode
            }
            else {
                currentNode?.next = insertingNode
            }
            return true
        }
    }
    
    //Insert after value
    func insert(_ afterValue: T, _ value: T) -> Bool {
        let insertingNode = Node(value)
        if head == nil {
            return false
        }
        else {
            var nextNode = head
            while nextNode != nil {
                nextNode = nextNode?.next
                if nextNode?.data == afterValue {
                    break
                }
            }
            insertingNode.next = nextNode?.next
            nextNode?.next = insertingNode
            
            return true
        }
    }
    
    //Remove node from head
    func pop() -> T? {
        if head == nil {
            return nil
        }
        else {
            let deletingNodeValue = head?.data
            head = head?.next
            return deletingNodeValue
        }
    }
    
    //Remove last node
    func removeLast() -> T? {
        if head == nil {
            return nil
        }
        else {
            var currentNode = head
            var nextNode = head
            while nextNode?.next != nil {
                currentNode = nextNode
                nextNode = nextNode?.next
            }
            let deletingNodeValue = nextNode?.data
            currentNode?.next = nil
            return deletingNodeValue
        }
    }
    
    //Remove value
    func removeValue(_ value: T) -> Bool {
        if head == nil {
            return false
        }
        else {
            var currentNode = head
            var nextNode = head
            while nextNode?.next != nil {
                if nextNode?.data == value {
                    break
                }
                currentNode = nextNode
                nextNode = nextNode?.next
            }
            currentNode?.next = nextNode?.next
            return true
        }
    }
    
    //Remove value at index
    func removeAt(_ index: Int) -> Bool {
        if head == nil {
            return false
        }
        else {
            var i = 0
            var currentNode = head
            var nextNode = head
            while nextNode?.next != nil {
                currentNode = nextNode
                nextNode = nextNode?.next
                if i == index {
                    break
                }
                i = i + 1
            }
            currentNode?.next = nextNode?.next
            if i == 0  {
                head = currentNode?.next
            }
            return true
        }
    }
}

extension LinkedList : CustomStringConvertible {
    var description: String {
        var nextNodeString = "head"
        if head != nil {
            var nextNode = head
            while (true) {
                if let node = nextNode {
                    nextNodeString = nextNodeString + " -> " + String(describing: node.data)
                }
                
                if nextNode?.next == nil {
                    nextNodeString = nextNodeString + " -> nil"
                    break
                }
                else {
                    nextNode = nextNode?.next!
                }
            }
        }
        else {
            nextNodeString = "head -> nil"
        }
        return nextNodeString
    }
}

let linkedList = LinkedList<Int>()
linkedList.append(5)
linkedList.append(6)

linkedList.push(15)
linkedList.push(16)

linkedList.append(7)
linkedList.append(8)
print("Linkedlist -> inserting after appending at end \(linkedList)")

linkedList.push(17)
linkedList.push(18)
print("Linkedlist -> inserting after pushing at start \(linkedList)")

linkedList.insertAt(1, 20)
print("Linkedlist -> inserting at 1st position  \(linkedList)")

linkedList.insert(17, 24)
print("Linkedlist -> inserting after 17  \(linkedList)")

linkedList.pop()
print("Linkedlist -> after popping \(linkedList)")

linkedList.removeLast()
print("Linkedlist -> after removing last \(linkedList)")


linkedList.removeValue(15)
print("Linkedlist -> after removing 15 \(linkedList)")

linkedList.removeAt(1)
print("Linkedlist -> after removing at index \(linkedList)")
