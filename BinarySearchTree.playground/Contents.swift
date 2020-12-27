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
                if queue.isEmpty() {
                    break
                }
                currentNode = queue.dequeue()
                if let currentNode = currentNode {
                    printingStatement += " -> " + String(describing: currentNode)
                }
            }
        }
        return printingStatement
    }
    
    func depthFirstTravesal(node: Node<T>? = nil, result: inout String) {
        let tranversingNode = node == nil ? root : node
        if let node = tranversingNode {
            result += " -> " + String(describing: node)
            if let left = node.left {
                depthFirstTravesal(node: left, result: &result)
            }
            
            if let right = node.right {
                depthFirstTravesal(node: right, result: &result)
            }
        }
    }
    
    func search(value: T) {
        var tranversingNode = root
        var itemFound = false
        while let node = tranversingNode {
            if node.data == value {
                itemFound = true
                print("\(value) found")
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
    
    func removeItem(value: T) {
        var current = root
        var previous = root
        while let currentData = current, (currentData.left != nil || currentData.right != nil) {
            if currentData.data > value {
                previous = current
                current = current?.left
            }
            else if currentData.data < value {
                previous = current
                current = current?.right
            }
            
            if current?.data == value {
                //If there is no left and right child of deleting node
                if current?.left == nil && current?.right == nil {
                    if previous?.right?.data == value {
                        previous?.right = nil
                    }
                    else if previous?.left?.data == value {
                        previous?.left = nil
                    }
                }
                //deleting node has either left or right child
                else if current?.left == nil || current?.right == nil {
                    let childNode = current?.left == nil ? current?.right : current?.left
                    if previous?.right?.data == value {
                        previous?.right = childNode
                    }
                    else if previous?.left?.data == value {
                        previous?.left = childNode
                    }
                }
                //deleting node has both right and left child
                else {
                    //find left most(smallest) element in right sub tree
                    let rightRootNode = current?.right
                    var parentLeftNode = rightRootNode
                    var smallestRightNode = rightRootNode
                    while smallestRightNode?.left != nil {
                        parentLeftNode = smallestRightNode
                        smallestRightNode = smallestRightNode?.left
                    }
                    //add the smallest node at the place of current node
                    if previous?.right?.data == value {
                        previous?.right = smallestRightNode
                    }
                    else if previous?.left?.data == value {
                        previous?.left = smallestRightNode
                    }
                    //Delete smallest node from end
                    if smallestRightNode?.data != parentLeftNode?.data {
                        parentLeftNode?.left = nil
                    }
                    //Add children of current node back
                    if smallestRightNode?.data != current?.right?.data {
                        smallestRightNode?.right = current?.right
                    }
                    smallestRightNode?.left = current?.left
                }
                
                return
            }
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

var tree = BinarySearchTree<Int>()
tree.append(25)
tree.append(15)
tree.append(10)
tree.append(50)
tree.append(35)
tree.append(70)
tree.append(23)
tree.append(12)
tree.append(13)
tree.append(11)
tree.append(14)
tree.append(24)
tree.append(31)
tree.append(44)
tree.append(66)
tree.append(90)

print("breathFirstTraversalByQueue Result: "+tree.breathFirstTraversalByQueue())

var depthFirstResult = ""
tree.depthFirstTravesal(node: nil, result: &depthFirstResult)
print("DepthFirstTravesal Result: "+depthFirstResult)

tree.search(value: 15)

var preOrderResult = ""
tree.preOrderTraversal(result: &preOrderResult)
print("preOrderTraversal Result: " + preOrderResult)

var inOrderResult = ""
tree.inOrderTraversal(node: nil, result: &inOrderResult)
print("inOrderTraversal Result: "+inOrderResult)

var postOrderResult = ""
tree.postOrderTraversal(result: &postOrderResult)
print("postOrderTraversal Result: "+postOrderResult)

tree.removeItem(value: 20)
print("breathFirstTraversalByQueue Result: "+tree.breathFirstTraversalByQueue())
