import UIKit

import UIKit

class Node<T> where T : Comparable {
    var data: T
    var left: Node?
    var right: Node?
    var parent : Node?
    var height: Int = 1
    init(_ value: T,_ left: Node? = nil,_ right: Node? = nil) {
        self.left = left
        self.right = right
        self.data = value
        self.left?.parent = self
        self.right?.parent = self
    }
    
    func setLeft(_ node: Node?) {
        self.left = node
        self.left?.parent = self
    }
    
    func setRight(_ node: Node?) {
        self.right = node
        self.right?.parent = self
    }
    
    func updateParentForLeftRightNodes() {
        self.left?.parent = self
        self.right?.parent = self
    }
}

extension Node : CustomStringConvertible {
    var description: String {
        let leftHeight = left?.height ?? 0
        let rightHeight = right?.height ?? 0
        let balancedFactor =  leftHeight - rightHeight
        
        return String(describing: "\(data)(\(height), \(balancedFactor))")
    }
}

class AVLTree<T> where T : Comparable {
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
                if data == currentData {
                    return
                }
                else if data < currentData {
                    if currentNode?.left == nil {
                        currentNode?.setLeft(node)
                        updateHeightUpwards(node: node, didRotate: false)
                        break
                    }
                    else {
                        currentNode = currentNode?.left
                    }
                }
                else {
                    if currentNode?.right == nil {
                        currentNode?.setRight(node)
                        updateHeightUpwards(node: node, didRotate: false)
                        break
                    }
                    else {
                        currentNode = currentNode?.right
                    }
                }
            }
        }
        adjustTreeIfImbalanced(node: node)
    }
    
    func updateHeightUpwards(node: Node<T>, didRotate: Bool) {
        var currentNode = node
        
        while let parent = currentNode.parent {
            parent.height = max(didRotate ? 0 : parent.height, currentNode.height + 1)
            currentNode = parent
        }
    }
    
    func adjustTreeIfImbalanced(node: Node<T>) {
        var currentNode = node
        
        while let currentParent = currentNode.parent {
            var parent = currentParent
            //print("\(parent) balanceFactor:\(calculateBalancedFactor(node:parent))")
            let balanceFactor = calculateBalancedFactor(node:parent)
            if balanceFactor < -1 || balanceFactor > 1 {
                
                if let leftChild = parent.left {
                    let leftChildBalanceFactor = calculateBalancedFactor(node:leftChild)
                    if balanceFactor == 2 && leftChildBalanceFactor == 1 {
                        leftRotate(node: parent, childNode: leftChild)
                    }
                    else if balanceFactor == 2 && leftChildBalanceFactor == -1, let rightChild = leftChild.right {
                        var grandRightChild = rightChild
                        leftRightRotate(node: &parent, childNode: leftChild, grandChildNode: &grandRightChild)
                    }
                }
                
                if let rightChild = parent.right {
                    let rightChildBalanceFactor = calculateBalancedFactor(node:rightChild)
                    if balanceFactor == -2 && rightChildBalanceFactor == -1 {
                        print("rightRotate parent:\(parent) rightChild:\(rightChild)")
                        rightRotate(node: parent, childNode: rightChild)
                    }
                    else if balanceFactor == -2 && rightChildBalanceFactor == 1, let leftChild = rightChild.left {
                        var grandLeftChild = leftChild
                        print("rightLeftRotate parent:\(parent) rightChild:\(rightChild) grandLeftChild:\(grandLeftChild)")
                        rightLeftRotate(node: &parent, childNode: rightChild, grandChildNode: &grandLeftChild)
                    }
                }
                
            }
            currentNode = parent
        }
    }
    
    func calculateBalancedFactor(node: Node<T>) -> Int {
        let leftHeight = node.left?.height ?? 0
        let rightHeight = node.right?.height ?? 0
        return leftHeight - rightHeight
    }
    
    func leftRotate(node: Node<T>, childNode: Node<T>) {
        if node.parent == nil {
            root = childNode
            childNode.parent = nil
        }
        
        let childRight = childNode.right
        childNode.setRight(node)
        node.setLeft(childRight ?? nil)
        
        if let childRight = childRight {
            updateHeightUpwards(node: childRight, didRotate: true)
        }
        else {
            node.height = 1
            updateHeightUpwards(node: node, didRotate: true)
        }
    }
    
    func rightRotate(node: Node<T>, childNode: Node<T>) {
        if node.parent == nil {
            root = childNode
            childNode.parent = nil
        }
        
        let childLeft = childNode.left
        childNode.setLeft(node)
        node.setRight(childLeft ?? nil)
        
        if let childLeft = childLeft {
            updateHeightUpwards(node: childLeft, didRotate: true)
        }
        else {
            node.height = 1
            updateHeightUpwards(node: node, didRotate: true)
        }
    }
    
    func leftRightRotate(node: inout Node<T>, childNode: Node<T>, grandChildNode: inout Node<T>) {
        let gChildBeforeUpdating = grandChildNode
        let parentBeforeChanging = node.parent
        
        let newNode = Node(grandChildNode.data, childNode, node)
        if parentBeforeChanging == nil {
            newNode.parent = nil
        }
        else {
            if parentBeforeChanging?.right?.data == node.data {
                parentBeforeChanging?.setRight(newNode)
            }
            else {
                parentBeforeChanging?.setLeft(newNode)
            }
        }
        
        node.setLeft(gChildBeforeUpdating.left ?? nil)
        childNode.setRight(nil)
        
        childNode.height = 1
        node.height = 1
        updateHeightUpwards(node: node, didRotate: true)
    }
    
    func rightLeftRotate(node: inout Node<T>, childNode: Node<T>, grandChildNode: inout Node<T>) {
        let gChildBeforeUpdating = grandChildNode
        let parentBeforeChanging = node.parent
    
        let newNode = Node(grandChildNode.data, node, childNode)
        if parentBeforeChanging == nil {
            newNode.parent = nil
        }
        else {
            if parentBeforeChanging?.right?.data == node.data {
                parentBeforeChanging?.setRight(newNode)
            }
            else {
                parentBeforeChanging?.setLeft(newNode)
            }
        }
        
        node.setRight(gChildBeforeUpdating.left ?? nil)
        childNode.setLeft(nil)
        
        childNode.height = 1
        node.height = 1
        updateHeightUpwards(node: node, didRotate: true)
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
}
var tree = AVLTree<Int>()
tree.append(40)
tree.append(20)
tree.append(10)

tree.append(25)
tree.append(30)
tree.append(22)
//tree.append(50)

var depthFirstResult = ""
tree.depthFirstTravesal(node: nil, result: &depthFirstResult)
print("DepthFirstTravesal Result: "+depthFirstResult)
