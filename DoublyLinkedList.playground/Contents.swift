import UIKit
import Foundation
class Node<T: Equatable> {
    var value: T
    var next : Node<T>?
    var previous : Node<T>?
    var tag : Int
    
    init(_ value: T, _ previous: Node<T>?, _ next: Node<T>?,_ tag: Int) {
        self.value = value
        self.next = next
        self.previous = previous
        self.tag = tag
    }
    
    static func ==(lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.tag == rhs.tag
    }
}

struct DoublyLinkedList<T: Equatable> {
    var head: Node<T>?
    init(head: Node<T>?) {
        self.head = head
    }
    
    var printLinkedList : String {
        var printableString = ""
        var current = head
        while let currentNode = current {
            printableString += ("\(String(describing: currentNode.value))")
            if let previousNode = currentNode.previous {
                printableString += "(\(String(describing: previousNode.value)))"
            }
            
            if currentNode.next != nil {
                printableString += " -> "
            }
            current = currentNode.next
        }
        return printableString
    }
    
    @discardableResult
    mutating func insertNodeAtHead(element: T,_ tag: Int) -> Node<T> {
        let node = Node(element, nil, head, tag)
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
               let node = Node(element, currentNode, nextNode, tag)
               currentNode?.next = node
               node.next?.previous = node
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
        
        let node = Node(element, currentNode, nil, tag)
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
                nextNode?.next?.previous = currentNode//for doubly linked list
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
        slowPointer?.next?.previous = previousPointer//for doubly linked list
        
        //If the index from end is thee head node
        if let slowPointer = slowPointer, let header = head, slowPointer == header {
            head = previousPointer?.next
        }
    }
}

var tag = 0
var node1 = Node(1, nil, nil, tag)
tag += 1
var node2 = Node(2, nil, node1, tag)
tag += 1
var node3 = Node(3, nil, node2, tag)
tag += 1
var node4 = Node(4, nil, node3, tag)

tag += 1
var node5 = Node(5, nil, node4, tag)

tag += 1
var node6 = Node(6, nil, node5, tag)

node1.previous = node2
node2.previous = node3
node3.previous = node4
node4.previous = node5
node5.previous = node6

var doublyLinkedList = DoublyLinkedList<Int>(head: node6)
print("Initial LinkedList:                \(doublyLinkedList.printLinkedList)")

tag += 1
doublyLinkedList.insertNodeAtIndex(element: 10, index:3, tag)
print("After adding 10 at index 3:        \(doublyLinkedList.printLinkedList)")

tag += 1
doublyLinkedList.insertAtEnd(element: 11, tag)
print("After adding 11 at end:            \(doublyLinkedList.printLinkedList)")

tag += 1
let headNode = doublyLinkedList.insertNodeAtHead(element: 15, tag)
print("After adding 15 at head:           \(doublyLinkedList.printLinkedList)")

doublyLinkedList.removeItem(index: 2)
print("After removing 2nd item:           \(doublyLinkedList.printLinkedList)")

doublyLinkedList.removeLastItem()
print("After removing last item:          \(doublyLinkedList.printLinkedList)")

doublyLinkedList.removeFromEndIndex(4)
print("After removing 4th items from end: \(doublyLinkedList.printLinkedList)")

