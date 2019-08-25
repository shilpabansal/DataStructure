import UIKit

class Node<T> where T : Comparable {
    var data: T
    var left: Node?
    var right: Node?
    init(_ value: T,_ left: Node? = nil,_ right: Node? = nil) {
        self.left = left
        self.right = right
        self.data = value
    }
}

extension Node : CustomStringConvertible {
    var description: String {
        return String(describing: "\(data)")
    }
}

class BinarySearchTree<T> where T : Comparable {
    var root : Node<T>?
    
    func append(_ data: T) {
        let node = Node(data, nil, nil)
        var currentNode = root
        while(true) {
            if currentNode == nil {
                root = node
                break
            }
            else if currentNode != nil, let currentData = currentNode?.data {
                if data < currentData {
                    if currentNode?.left == nil {
                        currentNode?.left = node
                        break
                    }
                    else {
                        currentNode = currentNode?.left
                    }
                }
                else {
                    if currentNode?.right == nil {
                        currentNode?.right = node
                        break
                    }
                    else {
                        currentNode = currentNode?.right
                    }
                }
            }
        }
    }
    
    func breathFirstTraversalByQueue() -> String {
        var currentNode = root
        let queue = Queue<Node<T>>()
        var printingStatement = ""
        if let root = root {
            printingStatement = " -> " + String(describing: root)
        }
        while(true) {
            if let node = currentNode {
                if let left = node.left {
                    queue.enque(left)
                }
                if let right = node.right {
                    queue.enque(right)
                }
                currentNode = queue.dequeue()
                if let currentNode = currentNode {
                    printingStatement += " -> " + String(describing: currentNode)
                }
                
                if queue.isEmpty() {
                    break
                }
            }
        }
        return printingStatement
    }
    
    func breathFirstTraversalByRecusrion(node: Node<T>? = nil, result: inout String) {
        if let root = root, node == nil {
            result += " -> " + String(describing: root)
        }
        let tranversingNode = node == nil ? root : node
        if let node = tranversingNode {
            if let left = node.left {
                result += " -> " + String(describing: left)
            }
            
            if let right = node.right {
                result += " -> " + String(describing: right)
            }
            
            if let left = node.left {
                breathFirstTraversalByRecusrion(node: left, result: &result)
            }
            if let right = node.right {
                breathFirstTraversalByRecusrion(node: right, result: &result)
            }
        }
    }
    
    func depthFirstTravesal(node: Node<T>? = nil, result: inout String) {
        let tranversingNode = node == nil ? root : node
        if let node = tranversingNode {
            if let left = node.left {
                depthFirstTravesal(node: left, result: &result)
            }
            
            if let right = node.right {
                depthFirstTravesal(node: right, result: &result)
            }
            result += " -> " + String(describing: node)
        }
    }
    
    func search(value: T) {
        var tranversingNode = root
        var itemFound = false
        while let node = tranversingNode {
            if node.data == value {
                itemFound = true
                print("Item found")
                break
            }
            else if node.data > value {
                tranversingNode = node.left
            }
            else {
                tranversingNode = node.right
            }
        }
        if !itemFound {
            print("Item not found")
        }
    }
    
    func inOrderTraversal(node: Node<T>? = nil, result: inout String) {
        let tranversingNode = node == nil ? root : node
        if let tranversingNode = tranversingNode {
            if let left = tranversingNode.left {
                inOrderTraversal(node: left, result: &result)
            }
            result += " -> " + String(describing: tranversingNode)
            if let right = tranversingNode.right {
                inOrderTraversal(node: right, result: &result)
            }
        }
    }
    
    func preOrderTraversal(node: Node<T>? = nil, result: inout String) {
        let tranversingNode = node == nil ? root : node
        if let tranversingNode = tranversingNode {
            result += " -> " + String(describing: tranversingNode)
            if let left = tranversingNode.left {
                preOrderTraversal(node: left, result: &result)
            }
            if let right = tranversingNode.right {
                preOrderTraversal(node: right, result: &result)
            }
        }
    }
    
    func postOrderTraversal(node: Node<T>? = nil, result: inout String) {
        let tranversingNode = node == nil ? root : node
        if let tranversingNode = tranversingNode {
            if let left = tranversingNode.left {
                postOrderTraversal(node: left, result: &result)
            }
            if let right = tranversingNode.right {
                postOrderTraversal(node: right, result: &result)
            }
            result += " -> " + String(describing: tranversingNode)
        }
    }
}

class Queue<T> {
    var array : [T] = []
    
    func isEmpty() -> Bool {
        return array.isEmpty
    }
    
    func peek() -> T? {
        return isEmpty() ? nil : array.first
    }
    
    func enque(_ value: T) {
        array.append(value)
    }
    
    func dequeue() -> T? {
        return isEmpty() ? nil : array.removeFirst()
    }
}

var tree = Tree<Int>()
tree.append(25)
tree.append(15)
tree.append(50)
tree.append(10)
tree.append(22)
tree.append(35)
tree.append(70)
tree.append(4)
tree.append(12)
tree.append(18)
tree.append(24)
tree.append(31)
tree.append(44)
tree.append(66)
tree.append(90)

print("breathFirstTraversalByQueue Result: "+tree.breathFirstTraversalByQueue())
var depthFirstResult = ""
tree.depthFirstTravesal(node: nil, result: &depthFirstResult)
print("DepthFirstTravesal Result: "+depthFirstResult)

var breathFirstResult = ""
tree.breathFirstTraversalByRecusrion(node: nil, result: &breathFirstResult)
print("breathFirstTraversalByRecusrion Result: "+breathFirstResult)

tree.search(value: 15)

var inOrderResult = ""
tree.inOrderTraversal(node: nil, result: &inOrderResult)
print("DepthFirstTravesal Result: "+inOrderResult)

