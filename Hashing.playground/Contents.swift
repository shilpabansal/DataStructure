import UIKit

class Hashing : CustomStringConvertible {
    var array : [LinkedList<Int?>] = [LinkedList<Int?>](repeating: LinkedList(head: nil), count: 10)

    init() {
    }
    
    func hashFunction(_ item: Int) -> Int {
        return item % array.count
    }
    
    func addElement(_ item: Int) {
        let index = hashFunction(item)
        
        var linkedList = array[index]
        if linkedList.head != nil {
            linkedList.insertAtEnd(element: item)
        }
        else {
            linkedList = LinkedList(head: Node(item, nil))
            array[index] = linkedList
        }
    }
    
    func searchElement(item: Int) -> Bool {
        let index = hashFunction(item)
        
        let linkedList = array[index]
        if linkedList.searchItem(data: item) != nil {
            return true
        }
        return false
    }
    
    func removeElement(item: Int) {
        let index = hashFunction(item)
        
        var linkedList = array[index]
        let isHead = linkedList.removeItem(element: item)
        if isHead {
            array[index] = LinkedList(head: nil)
        }
    }
    
    var description: String {
        var hashing = ""
        array.forEach {
            hashing += "\n" + $0.printLinkedList
        }
        return hashing
    }
}

class Node<T: Equatable> : CustomStringConvertible {
    var value: T
    var next : Node<T>?
    
    init(_ value: T, _ next: Node<T>?) {
        self.value = value
        self.next = next
    }
    
    var description: String {
        return "\(value)"
    }
}

struct LinkedList<T: Equatable> {
    var head: Node<T>?
    init(head: Node<T>?) {
        self.head = head
    }
    
    var printLinkedList : String {
        var printableString = ""
        var current = head
        while let currentNode = current {
            printableString += ("\(currentNode)")
            
            if currentNode.next != nil {
                printableString += " -> "
            }
            current = currentNode.next
        }
        return printableString
    }
    
    @discardableResult
    func searchItem(data: T) -> Node<T>? {
        var currentNode = head
        
        if currentNode == nil {
           return nil
        }
        while currentNode?.next != nil {
            if currentNode?.value == data {
                return currentNode
            }
            currentNode = currentNode?.next
        }
        return nil
    }
    
    @discardableResult
    mutating func insertAtEnd(element: T) -> Node<T> {
        var currentNode = head
        
        if currentNode == nil {
           let node = Node(element, head)
            head = node
            return node
        }
        while currentNode?.next != nil {
           currentNode = currentNode?.next
        }
        
        let node = Node(element, nil)
        currentNode?.next = node
        return node
    }
    
    mutating func removeItem(element: T) -> Bool {
        var fastPointer = head
        var slowPointer = head
        
        while fastPointer != nil {
            if fastPointer?.value == element {
                if fastPointer?.value == slowPointer?.value {
                    head = nil
                    return true
                }
                slowPointer?.next = fastPointer?.next == nil ? nil : fastPointer?.next
                fastPointer = nil
                return false
            }
            slowPointer = fastPointer
            fastPointer = fastPointer?.next
        }
        return false
    }
}

var hashing = Hashing()
hashing.addElement(1)
hashing.addElement(2)
hashing.addElement(3)
hashing.addElement(4)
hashing.addElement(5)
hashing.addElement(6)
hashing.addElement(7)
hashing.addElement(9)


hashing.addElement(19)
hashing.addElement(29)
hashing.addElement(39)
hashing.addElement(49)

print(hashing)
print("search 29: \(hashing.searchElement(item: 29))")
print("search 59: \(hashing.searchElement(item: 59))")

hashing.removeElement(item: 39)
print("After deleting 39: \(hashing)")


hashing.removeElement(item: 7)
print("After deleting 7: \(hashing)")
