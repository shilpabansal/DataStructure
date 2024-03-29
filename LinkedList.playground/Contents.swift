import UIKit
import Foundation
class Node<T: Equatable> {
    var value: T
    var next : Node<T>?
    var previous : Node<T>?
    var tag : Int
    
    init(_ value: T, _ next: Node<T>?,_ tag: Int) {
        self.value = value
        self.next = next
        self.tag = tag
    }
    
    static func ==(lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.tag == rhs.tag
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
            printableString += ("\(String(describing: currentNode.value))")
            if currentNode.next != nil {
                printableString += " -> "
            }
            current = currentNode.next
        }
        return printableString
    }
    
    @discardableResult
    mutating func insertNodeAtHead(element: T,_ tag: Int) -> Node<T> {
        let node = Node(element, head, tag)
        head = node
        return node
    }
    
    @discardableResult
    mutating func insertNodeAtIndex(element: T, index: Int,_ tag: Int) -> Node<T>? {
        if index == 0 {
            let node = insertNodeAtHead(element: element, tag)
            return node
        }
        var currentNode = head
        var nextNode : Node<T>? = currentNode?.next
        var currentIndex = 0
        while currentNode != nil {
           currentIndex += 1
           if currentIndex == index {
               let node = Node(element, nextNode, tag)
               currentNode?.next = node
               return node
           }
           currentNode = currentNode?.next
           nextNode = currentNode?.next
        }
        
        print("Couldn't add at index \(index), as there are less items in the list")
        return nil
    }
    
    @discardableResult
    mutating func insertAtEnd(element: T,_ tag: Int) -> Node<T> {
        var currentNode = head
        
        if currentNode == nil {
            let node = insertNodeAtHead(element: element, tag)
            return node
        }
        while currentNode?.next != nil {
           currentNode = currentNode?.next
        }
        
        let node = Node(element, nil, tag)
        currentNode?.next = node
        return node
    }
    
    mutating func removeItem(index: Int) {
        var currentNode = head
        var nextNode : Node<T>? = currentNode?.next
        var currentIndex = 0
        if index == 0 {
            head = head?.next
            return
        }
        while currentNode != nil {
           currentIndex += 1
           if currentIndex == index {
                currentNode?.next = nextNode?.next
                return
           }
           currentNode = currentNode?.next
           nextNode = currentNode?.next
        }
    }
    
    mutating func removeLastItem() {
        var currentNode = head
        var previousNode = head
        if currentNode?.next == nil {
            head = nil
            return
        }
        while currentNode?.next != nil {
           previousNode = currentNode
           currentNode = currentNode?.next
        }
        previousNode?.next = nil
    }
    
    mutating func removeFromEndIndex(_ index: Int) {
        var fastPointer = head
        var slowPointer = head
        var currentIndex = 0
        while currentIndex < index {
            currentIndex += 1
            fastPointer = fastPointer?.next
        }
        var previousPointer = slowPointer
        while fastPointer != nil {
           previousPointer = slowPointer
           slowPointer = slowPointer?.next
           fastPointer = fastPointer?.next
        }
        previousPointer?.next = slowPointer?.next
        
        //If the index from end is thee head node
        if let slowPointer = slowPointer, let header = head, slowPointer == header {
            head = previousPointer?.next
        }
    }
    
    func breakLoopInLinkedListIfExists(){
        var slowPointer = head
        var fastPointer = head
        var previousPointer = head
        while fastPointer != nil, slowPointer != nil {
            fastPointer = fastPointer?.next?.next
            previousPointer = slowPointer
            slowPointer = slowPointer?.next
            if let slowPointer = slowPointer, let fastPointer = fastPointer, slowPointer == fastPointer {
                if let head = head, fastPointer == head {
                    previousPointer?.next = nil
                }
                else {
                    fastPointer.next = nil
                }
                return
          }
        }
    }
}

var tag = 0
var node1 = Node(1, nil, tag)
tag += 1
var node2 = Node(2, node1, tag)
tag += 1
var node3 = Node(3, node2, tag)
tag += 1
var node4 = Node(4, node3, tag)

tag += 1
var node5 = Node(5, node4, tag)

tag += 1
var node6 = Node(6, node5, tag)

var linkedList = LinkedList<Int>(head: node6)
print("Initial LinkedList:                \(linkedList.printLinkedList)")

tag += 1
linkedList.insertNodeAtIndex(element: 10, index:3, tag)
print("After adding 10 at index 3:        \(linkedList.printLinkedList)")

tag += 1
linkedList.insertAtEnd(element: 11, tag)
print("After adding 11 at end:            \(linkedList.printLinkedList)")

tag += 1
let headNode = linkedList.insertNodeAtHead(element: 15, tag)
print("After adding 15 at head:           \(linkedList.printLinkedList)")

linkedList.removeItem(index: 2)
print("After removing 2nd item:           \(linkedList.printLinkedList)")

linkedList.removeLastItem()
print("After removing last item:          \(linkedList.printLinkedList)")

linkedList.removeFromEndIndex(4)
print("After removing 4th items from end: \(linkedList.printLinkedList)")

//making loop from last node to head
node1.next = headNode
linkedList.breakLoopInLinkedListIfExists()
print("After removing the loop to head:   \(linkedList.printLinkedList)")


//15 -> 3 -> 10 -> 2 -> 1
//making loop from 2 to 3
node2.next = node6
linkedList.breakLoopInLinkedListIfExists()
print("After removing the loop:           \(linkedList.printLinkedList)")

