import UIKit

class Node<T> {
    var data: T
    var next: Node?
    
    init(_ data: T, next: Node<T>? = nil) {
        self.data = data
        self.next = next
    }
    
    func getData() -> T {
        return data
    }
    
    func getNext() -> Node? {
        return next
    }
}

extension Node: Equatable where T: Comparable {
    static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.data == rhs.data
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        return "\(data)"
    }
}

class LinkedList<T> where T: Comparable {
    var root: Node<T>?
    
    func append(_ data: T) {
        let insertingNode = Node(data)
        if root == nil {
            root = insertingNode
        }
        else {
            var nextNode = root
            while nextNode?.next != nil {
                nextNode = nextNode?.next
            }
            nextNode?.next = insertingNode
        }
    }
    
    func reverse() {
        var pre: Node<T>?
        var currentNode = root
        var next: Node<T>?
        
        while currentNode != nil {
            next = currentNode?.next
            currentNode?.next = pre
            pre = currentNode
            currentNode = next
        }
        root = pre
    }
}

extension LinkedList: CustomStringConvertible {
    var description: String {
        var result = ""
        
        var nextNode = root
        while let newNode = nextNode {
            result += "\(newNode) -> "
            nextNode = newNode.next
            
            if nextNode == nil {
                result += "nil"
            }
        }
        return result
    }
}

var linkedList = LinkedList<Int>()
linkedList.append(1)
linkedList.append(2)
linkedList.append(3)
linkedList.append(4)
print(linkedList)

linkedList.reverse()
print(linkedList)
